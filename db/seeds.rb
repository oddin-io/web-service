# Users
# ======================================================================================================================
eloize_user = User.create email: 'eloize@ifsp.com', password: '12345678'
silvana_user = User.create email: 'silvana@ifsp.com', password: '12345678'
pablo_user = User.create email: 'pablo@ifsp.com', password: '12345678'
celia_user = User.create email: 'celia@ifsp.com', password: '12345678'
miriam_user = User.create email: 'miriam@ifsp.com', password: '12345678'
bruno_user = User.create email: 'bruno@gmail.com', password: '12345678'
heitor_user = User.create email: 'heitor@gmail.com', password: '12345678'
leonardo_user = User.create email: 'leonardo@gmail.com', password: '12345678'
ana_user = User.create email: 'ana@gmail.com', password: '12345678'

# People
# ======================================================================================================================
eloize_person = Person.create name: 'Eloize', user: eloize_user
silvana_person = Person.create name: 'Silvana', user: silvana_user
pablo_person = Person.create name: 'Pablo', user: pablo_user
celia_person = Person.create name: 'Célia', user: celia_user
miriam_person = Person.create name: 'Miriam', user: miriam_user
bruno_person = Person.create name: 'Bruno', user: bruno_user
heitor_person = Person.create name: 'Francisco', user: heitor_user
leonardo_person = Person.create name: 'Leonardo', user: leonardo_user
ana_person = Person.create name: 'Ana', user: ana_user

# Events
# ======================================================================================================================
ads_event = Event.create code: 'ADS', name: 'Tecnologia em Análise e Desenvolvimento de Sistemas', workload: 2100.7

# Lectures
# ======================================================================================================================
foc_lecture = Lecture.create code: 'FOC', name: 'Administração Financeira, Orçamentária e Contábil', workload: 79.2
eng_lecture = Lecture.create code: 'ENG', name: 'Engenharia de Software', workload: 79.2
iso_lecture = Lecture.create code: 'ISO', name: 'Introdução a Sistemas Operacionais', workload: 63.3
bd1_lecture = Lecture.create code: 'BD1', name: 'Banco de Dados I', workload: 79.2
lp1_lecture = Lecture.create code: 'LP1', name: 'Linguagem de Programação I', workload: 79.2

# Instructions
# ======================================================================================================================
foc_c1_instruction = Instruction.create event: ads_event , lecture: foc_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
eng_c1_instruction = Instruction.create event: ads_event , lecture: eng_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
iso_c1_instruction = Instruction.create event: ads_event , lecture: iso_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
bd1_c1_instruction = Instruction.create event: ads_event , lecture: bd1_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
bd1_c2_instruction = Instruction.create event: ads_event , lecture: bd1_lecture, class_number: 2, start_date: '2015-07-28', end_date: '2015-12-22'
lp1_c1_instruction = Instruction.create event: ads_event , lecture: lp1_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
lp1_c2_instruction = Instruction.create event: ads_event , lecture: lp1_lecture, class_number: 2, start_date: '2015-07-28', end_date: '2015-12-22'

# Enrolls
# ======================================================================================================================
Enroll.create person: miriam_person, instruction: foc_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: foc_c1_instruction, profile: 0
Enroll.create person: heitor_person, instruction: foc_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: foc_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: foc_c1_instruction, profile: 0

Enroll.create person: pablo_person, instruction: eng_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: eng_c1_instruction, profile: 0
Enroll.create person: heitor_person, instruction: eng_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: eng_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: eng_c1_instruction, profile: 0

Enroll.create person: celia_person, instruction: iso_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: iso_c1_instruction, profile: 0
Enroll.create person: heitor_person, instruction: iso_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: iso_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: iso_c1_instruction, profile: 0

Enroll.create person: silvana_person, instruction: bd1_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: bd1_c1_instruction, profile: 0
Enroll.create person: heitor_person, instruction: bd1_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: bd1_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: bd1_c1_instruction, profile: 0

Enroll.create person: silvana_person, instruction: bd1_c2_instruction, profile: 1
Enroll.create person: bruno_person, instruction: bd1_c2_instruction, profile: 0
Enroll.create person: heitor_person, instruction: bd1_c2_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: bd1_c2_instruction, profile: 0
Enroll.create person: ana_person, instruction: bd1_c2_instruction, profile: 0

Enroll.create person: eloize_person, instruction: lp1_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: lp1_c1_instruction, profile: 0
Enroll.create person: heitor_person, instruction: lp1_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: lp1_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: lp1_c1_instruction, profile: 0

Enroll.create person: eloize_person, instruction: lp1_c2_instruction, profile: 1
Enroll.create person: bruno_person, instruction: lp1_c2_instruction, profile: 0
Enroll.create person: heitor_person, instruction: lp1_c2_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: lp1_c2_instruction, profile: 0
Enroll.create person: ana_person, instruction: lp1_c2_instruction, profile: 0

# Presentations
# ======================================================================================================================
bd1_c1_presentation = Presentation.create subject: Faker::Hacker.adjective, person: silvana_person, instruction: bd1_c1_instruction

# Questions
# ======================================================================================================================
question_1 = Question.create person: bruno_person, text: Faker::StarWars.quote, presentation: bd1_c1_presentation
question_2 = Question.create person: bruno_person, text: Faker::StarWars.quote, presentation: bd1_c1_presentation
question_3 = Question.create person: ana_person, text: Faker::StarWars.quote, presentation: bd1_c1_presentation
question_4 = Question.create person: ana_person, text: Faker::StarWars.quote, presentation: bd1_c1_presentation

# Answers
# ======================================================================================================================
answer_1 = Answer.create person: ana_person, text: Faker::StarWars.quote, question: question_1
answer_2 = Answer.create person: ana_person, text: Faker::StarWars.quote, question: question_2
answer_3 = Answer.create person: bruno_person, text: Faker::StarWars.quote, question: question_3
answer_4 = Answer.create person: bruno_person, text: Faker::StarWars.quote, question: question_4

# Votes
# ======================================================================================================================
Vote.create person: ana_person, votable: question_1
Vote.create person: heitor_person, up: false, votable: question_1
Vote.create person: ana_person, up: false, votable: question_2
Vote.create person: heitor_person, votable: question_2
Vote.create person: bruno_person, up: false, votable: question_3
Vote.create person: heitor_person, votable: question_3
Vote.create person: bruno_person, votable: question_4
Vote.create person: heitor_person, up: false, votable: question_4

Vote.create person: bruno_person, up: false, votable: answer_3
Vote.create person: heitor_person, votable: answer_3
Vote.create person: bruno_person, votable: answer_4
Vote.create person: heitor_person, up: false, votable: answer_4
Vote.create person: ana_person, votable: answer_1
Vote.create person: heitor_person, up: false, votable: answer_1
Vote.create person: ana_person, up: false, votable: answer_2
Vote.create person: heitor_person, votable: answer_2
