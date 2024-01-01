from flask import Flask, request, jsonify
import pickle
import numpy as np
from skfuzzy import control as ctrl
from flask_cors import CORS 

app = Flask(__name__)
CORS(app) 

# Load the fuzzy control systems from the pickle file
with open('fuzzy_models.pkl', 'rb') as file:
    loaded_models_dict = pickle.load(file)

# Access each model by its key
loaded_counting_model = loaded_models_dict['counting_model']
loaded_coloring_model = loaded_models_dict['coloring_model']
loaded_combined_model = loaded_models_dict['combined_model']

def apply_fuzzy_logic(model, counting_input, color_input):
    model.input['Counting_Ability'] = np.mean(counting_input)
    model.input['Color_Ability'] = np.mean(color_input)
    model.compute()
    return model.output['Percentage']

@app.route('/')
def index():
    return 'Welcome to Fuzzy Logic API'

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()

    counting_input = data['counting_input']
    color_input = data['color_input']

    prediction_counting = apply_fuzzy_logic(loaded_counting_model, counting_input, color_input)
    prediction_coloring = apply_fuzzy_logic(loaded_coloring_model, counting_input, color_input)
    prediction_combined = apply_fuzzy_logic(loaded_combined_model, counting_input, color_input)

    result = {
        'prediction_counting': prediction_counting,
        'prediction_coloring': prediction_coloring,
        'prediction_combined': prediction_combined
    }

    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
