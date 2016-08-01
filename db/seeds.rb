# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

celia_user = User.create email: 'celia@ifsp.com', password: '12345678'
eloize_user = User.create email: 'eloize@ifsp.com', password: '12345678'
silvana_user = User.create email: 'silvana@ifsp.com', password: '12345678'
pablo_user = User.create email: 'pablo@ifsp.com', password: '12345678'
miriam_user = User.create email: 'miriam@ifsp.com', password: '12345678'
bruno_user = User.create email: 'bruno@gmail.com', password: '12345678'
francisco_user = User.create email: 'francisco@gmail.com', password: '12345678'
leonardo_user = User.create email: 'leonardo@gmail.com', password: '12345678'
ana_user = User.create email: 'ana@gmail.com', password: '12345678'

miriam_person = Person.create name: 'Miriam', user_id: miriam_user.id
pablo_person = Person.create name: 'Pablo', user_id: pablo_user.id
celia_person = Person.create name: 'Célia', user_id: celia_user.id
silvana_person = Person.create name: 'Silvana', user_id: silvana_user.id
eloize_person = Person.create name: 'Eloize', user_id: eloize_user.id
bruno_person = Person.create name: 'Bruno', user_id: bruno_user.id
francisco_person = Person.create name: 'Francisco', user_id: francisco_user.id
leonardo_person = Person.create name: 'Leonardo', user_id: leonardo_user.id
ana_person = Person.create name: 'Ana', user_id: ana_user.id

ads_event = Event.create code: 'ADS', name: 'Tecnologia em Análise e Desenvolvimento de Sistemas', workload: 2100.7

foc_lecture = Lecture.create code: 'FOC', name: 'Administração Financeira, Orçamentária e Contábil', workload: 79.2
eng_lecture = Lecture.create code: 'ENG', name: 'Engenharia de Software', workload: 79.2
iso_lecture = Lecture.create code: 'ISO', name: 'Introdução a Sistemas Operacionais', workload: 63.3
bd1_lecture = Lecture.create code: 'BD1', name: 'Banco de Dados I', workload: 79.2
lp1_lecture = Lecture.create code: 'LP1', name: 'Linguagem de Programação I', workload: 79.2

foc_c1_instruction = Instruction.create event_id: ads_event.id , lecture_id: foc_lecture.id, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
eng_c1_instruction = Instruction.create event_id: ads_event.id , lecture_id: eng_lecture.id, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
iso_c1_instruction = Instruction.create event_id: ads_event.id , lecture_id: iso_lecture.id, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
bd1_c1_instruction = Instruction.create event_id: ads_event.id , lecture_id: bd1_lecture.id, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
bd1_c2_instruction = Instruction.create event_id: ads_event.id , lecture_id: bd1_lecture.id, class_number: 2, start_date: '2015-07-28', end_date: '2015-12-22'
lp1_c1_instruction = Instruction.create event_id: ads_event.id , lecture_id: lp1_lecture.id, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
lp1_c2_instruction = Instruction.create event_id: ads_event.id , lecture_id: lp1_lecture.id, class_number: 2, start_date: '2015-07-28', end_date: '2015-12-22'

Enroll.create person_id: miriam_person.id, instruction_id: foc_c1_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: foc_c1_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: foc_c1_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: foc_c1_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: foc_c1_instruction.id, profile: 0

Enroll.create person_id: pablo_person.id, instruction_id: eng_c1_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: eng_c1_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: eng_c1_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: eng_c1_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: eng_c1_instruction.id, profile: 0

Enroll.create person_id: celia_person.id, instruction_id: iso_c1_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: iso_c1_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: iso_c1_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: iso_c1_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: iso_c1_instruction.id, profile: 0

Enroll.create person_id: silvana_person.id, instruction_id: bd1_c1_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: bd1_c1_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: bd1_c1_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: bd1_c1_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: bd1_c1_instruction.id, profile: 0

Enroll.create person_id: silvana_person.id, instruction_id: bd1_c2_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: bd1_c2_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: bd1_c2_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: bd1_c2_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: bd1_c2_instruction.id, profile: 0

Enroll.create person_id: eloize_person.id, instruction_id: lp1_c1_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: lp1_c1_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: lp1_c1_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: lp1_c1_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: lp1_c1_instruction.id, profile: 0

Enroll.create person_id: eloize_person.id, instruction_id: lp1_c2_instruction.id, profile: 1
Enroll.create person_id: bruno_person.id, instruction_id: lp1_c2_instruction.id, profile: 0
Enroll.create person_id: francisco_person.id, instruction_id: lp1_c2_instruction.id, profile: 0
Enroll.create person_id: leonardo_person.id, instruction_id: lp1_c2_instruction.id, profile: 0
Enroll.create person_id: ana_person.id, instruction_id: lp1_c2_instruction.id, profile: 0