# app.py (Flask backend)

from flask import Flask, request, jsonify
import pickle
from flask_cors import CORS 
import numpy as np

app = Flask(__name__)
CORS(app) 

def apply_fuzzy_logic_system(counting_input, color_input, simulator):
    # Use the mean of input lists for counting and coloring abilities
    simulator.input['Counting_Ability'] = np.mean(counting_input)
    simulator.input['Color_Ability'] = np.mean(color_input)
    simulator.compute()

    return simulator.output['Percentage']

# Load the fuzzy model from the pickle file
with open('fuzzy_model.pkl', 'rb') as file:
    loaded_fuzzy_simulator = pickle.load(file)

@app.route('/')
def main_page():
    return 'Hello world'

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()

        # Assuming the 'userAnswers' field is a list of booleans
        counting_input = data['counting_input']
        color_input = data['color_input']

        # Apply the trained fuzzy logic system on the new input
        prediction = apply_fuzzy_logic_system(counting_input, color_input, loaded_fuzzy_simulator)

        return jsonify({'prediction': prediction})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
