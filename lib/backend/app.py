# app.py (Flask backend)

from flask import Flask, request, jsonify,render_template
import pickle
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS 
import numpy as np
from sqlalchemy.orm import relationship

app = Flask(__name__)
CORS(app) 

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'

db = SQLAlchemy(app)

class registration(db.Model):
    firebase_uid = db.Column(db.String(100),primary_key=True)
    username = db.Column(db.String(100),nullable=False)
    email = db.Column(db.String(120),nullable=False)
    password = db.Column(db.String(50),nullable=False)

    user_profile = relationship('UserProfile', backref='registration', uselist=False)

    def __repr__(self):
        return f"Registration('{self.username}', '{self.email}')"

class UserProfile(db.Model):
    firebase_uid = db.Column(db.String(100), db.ForeignKey('registration.firebase_uid'), primary_key=True)
    child_name = db.Column(db.String(100), nullable=False)
    child_age = db.Column(db.Integer, nullable=False)
    parent_name = db.Column(db.String(100), nullable=False)
    parent_phone_number = db.Column(db.Integer, nullable=False)
    address = db.Column(db.String(255), nullable=False)

    def __repr__(self):
        return f"UserProfile('{self.child_name}', '{self.parent_name}', '{self.parent_email}')"


class Quiz1(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    
    firebase_uid = db.Column(db.Integer, db.ForeignKey('registration.firebase_uid'), nullable=False)
    quiz_id = db.Column(db.Integer,nullable=False)


    question1_id = db.Column(db.Integer, db.ForeignKey('questions.id'), nullable=False)
    question2_id = db.Column(db.Integer, db.ForeignKey('questions.id'), nullable=False)
    question3_id = db.Column(db.Integer, db.ForeignKey('questions.id'), nullable=False)
    question4_id = db.Column(db.Integer, db.ForeignKey('questions.id'), nullable=False)
    question5_id = db.Column(db.Integer, db.ForeignKey('questions.id'), nullable=False)
    average_result = db.Column(db.Integer,nullable=False)

#hello

class Questions(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    quiz_id = db.Column(db.Integer,nullable=False)
    question_id = db.Column(db.Integer, nullable=False)
    options = db.Column(db.String(255), nullable=False)  # Assuming options are stored as a single string

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
    # return 'Hello world'
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()

        counting_input = data['counting_input']
        color_input = data['color_input']

        # Assuming you also receive user profile information in the request
        # user_profile_data = data['user_profile']

        # # Save the user profile data to the database
        # user_profile = UserProfile(**user_profile_data)
        # db.session.add(user_profile)
        # db.session.commit()

        # Apply the trained fuzzy logic system on the new input
        prediction = apply_fuzzy_logic_system(counting_input, color_input, loaded_fuzzy_simulator)

        return jsonify({'prediction': prediction})

    except Exception as e:
        return jsonify({'error': str(e)})

# def user_profiles():
#     try:
#         # Query all user profiles from the database
#         profiles = UserProfile.query.all()

#         # Convert the profiles to a list of dictionaries
#         profiles_data = [
#             {
#                 'firebase_uid': profile.firebase_uid,
#                 'child_name': profile.child_name,
#                 'child_age': profile.child_age,
#                 'parent_name': profile.parent_name,
#                 'parent_phone_number': profile.parent_phone_number,
#                 'address': profile.address,
#             }
#             for profile in profiles
#         ]

#         print(profiles_data)

#         # Return a JSON response containing the profiles
#         return jsonify({'profiles': profiles_data})

#     except Exception as e:
#         return jsonify({'error': str(e)})
    

@app.route('/save_user_details', methods=['POST'])
def save_user_details():
    try:
        data = request.get_json()
        print(data)
        user_profile_data = {
            'firebase_uid': data['uid'],
            'child_name': data['child_name'],
            'child_age': data['child_age'],
            'parent_name': data['parent_name'],
            'parent_phone_number': data['parent_phone_number'],
            'address': data['address'],
        }

        # Check if the user profile already exists in the database
        existing_profile = UserProfile.query.filter_by(firebase_uid=user_profile_data['firebase_uid']).first()

        if existing_profile:
            # Update the existing user profile
            existing_profile.child_name = user_profile_data['child_name']
            existing_profile.child_age = user_profile_data['child_age']
            existing_profile.parent_name = user_profile_data['parent_name']
            existing_profile.parent_phone_number = user_profile_data['parent_phone_number']
            existing_profile.address = user_profile_data['address']
        else:
            # Create a new user profile
            user_profile = UserProfile(firebase_uid = user_profile_data['firebase_uid'],child_name = user_profile_data['child_name'],child_age = user_profile_data['child_age'],parent_name = user_profile_data['parent_name'],parent_phone_number=user_profile_data['parent_phone_number'],address = user_profile_data['address'])
            db.session.add(user_profile)

        db.session.commit()

        return jsonify({'message': 'User details saved successfully'})

    except Exception as e:
        return jsonify({'error': str(e)})

@app.route('/register_user', methods=['POST'])
def register_user():
    try:
        data = request.get_json()

        registration_data = {
            'username': data['username'],
            'email': data['email'],
            'password': data['password'],
            'firebase_uid' : data['uid']

        }
        new_registration = registration(firebase_uid=registration_data['firebase_uid'], username=registration_data['username'], email=registration_data['email'], password=registration_data['password'])
        
        db.session.add(new_registration)
        db.session.commit()

        return jsonify({'message': 'Registration successful'})

    except Exception as e:
        return jsonify({'error': str(e)})
    
@app.route('/quiz_update', methods=['POST'])
def quiz_update():
    try:
        data = request.get_json()

        questionids = data.get('questionids', [])
        quizid = data.get('quizid')
        avg_result = data.get('avg_result')

        # Extract Firebase UID from the request data
        firebase_uid = data.get('uid')

        # Create a new instance of Quiz1 model
        new_quiz_update = Quiz1(
            firebase_uid=firebase_uid,
            quiz_id=quizid,
            question1_id=questionids[0],
            question2_id=questionids[1],
            question3_id=questionids[2],
            question4_id=questionids[3],
            question5_id=questionids[4],
            average_result=avg_result
        )

        # Add the new instance to the session and commit changes
        db.session.add(new_quiz_update)
        db.session.commit()

        return jsonify({'message': 'Quiz update successful'})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    with app.app_context():
        # db.drop_all()  
        db.create_all()

    app.run(debug=True,port=5566) # here i changed the port because it was showing 5000 is already in use
