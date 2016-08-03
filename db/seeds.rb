eloize_user = User.create email: 'eloize@ifsp.com', password: '12345678'
silvana_user = User.create email: 'silvana@ifsp.com', password: '12345678'
pablo_user = User.create email: 'pablo@ifsp.com', password: '12345678'
celia_user = User.create email: 'celia@ifsp.com', password: '12345678'
miriam_user = User.create email: 'miriam@ifsp.com', password: '12345678'
bruno_user = User.create email: 'bruno@gmail.com', password: '12345678'
heitor_user = User.create email: 'heitor@gmail.com', password: '12345678'
leonardo_user = User.create email: 'leonardo@gmail.com', password: '12345678'
ana_user = User.create email: 'ana@gmail.com', password: '12345678'

eloize_person = Person.create name: 'Eloize', user: eloize_user
silvana_person = Person.create name: 'Silvana', user: silvana_user
pablo_person = Person.create name: 'Pablo', user: pablo_user
celia_person = Person.create name: 'Célia', user: celia_user
miriam_person = Person.create name: 'Miriam', user: miriam_user
bruno_person = Person.create name: 'Bruno', user: bruno_user
francisco_person = Person.create name: 'Francisco', user: heitor_user
leonardo_person = Person.create name: 'Leonardo', user: leonardo_user
ana_person = Person.create name: 'Ana', user: ana_user

ads_event = Event.create code: 'ADS', name: 'Tecnologia em Análise e Desenvolvimento de Sistemas', workload: 2100.7

foc_lecture = Lecture.create code: 'FOC', name: 'Administração Financeira, Orçamentária e Contábil', workload: 79.2
eng_lecture = Lecture.create code: 'ENG', name: 'Engenharia de Software', workload: 79.2
iso_lecture = Lecture.create code: 'ISO', name: 'Introdução a Sistemas Operacionais', workload: 63.3
bd1_lecture = Lecture.create code: 'BD1', name: 'Banco de Dados I', workload: 79.2
lp1_lecture = Lecture.create code: 'LP1', name: 'Linguagem de Programação I', workload: 79.2

foc_c1_instruction = Instruction.create event: ads_event , lecture: foc_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
eng_c1_instruction = Instruction.create event: ads_event , lecture: eng_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
iso_c1_instruction = Instruction.create event: ads_event , lecture: iso_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
bd1_c1_instruction = Instruction.create event: ads_event , lecture: bd1_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
bd1_c2_instruction = Instruction.create event: ads_event , lecture: bd1_lecture, class_number: 2, start_date: '2015-07-28', end_date: '2015-12-22'
lp1_c1_instruction = Instruction.create event: ads_event , lecture: lp1_lecture, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'
lp1_c2_instruction = Instruction.create event: ads_event , lecture: lp1_lecture, class_number: 2, start_date: '2015-07-28', end_date: '2015-12-22'

Enroll.create person: miriam_person, instruction: foc_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: foc_c1_instruction, profile: 0
Enroll.create person: francisco_person, instruction: foc_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: foc_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: foc_c1_instruction, profile: 0

Enroll.create person: pablo_person, instruction: eng_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: eng_c1_instruction, profile: 0
Enroll.create person: francisco_person, instruction: eng_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: eng_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: eng_c1_instruction, profile: 0

Enroll.create person: celia_person, instruction: iso_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: iso_c1_instruction, profile: 0
Enroll.create person: francisco_person, instruction: iso_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: iso_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: iso_c1_instruction, profile: 0

Enroll.create person: silvana_person, instruction: bd1_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: bd1_c1_instruction, profile: 0
Enroll.create person: francisco_person, instruction: bd1_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: bd1_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: bd1_c1_instruction, profile: 0

Enroll.create person: silvana_person, instruction: bd1_c2_instruction, profile: 1
Enroll.create person: bruno_person, instruction: bd1_c2_instruction, profile: 0
Enroll.create person: francisco_person, instruction: bd1_c2_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: bd1_c2_instruction, profile: 0
Enroll.create person: ana_person, instruction: bd1_c2_instruction, profile: 0

Enroll.create person: eloize_person, instruction: lp1_c1_instruction, profile: 1
Enroll.create person: bruno_person, instruction: lp1_c1_instruction, profile: 0
Enroll.create person: francisco_person, instruction: lp1_c1_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: lp1_c1_instruction, profile: 0
Enroll.create person: ana_person, instruction: lp1_c1_instruction, profile: 0

Enroll.create person: eloize_person, instruction: lp1_c2_instruction, profile: 1
Enroll.create person: bruno_person, instruction: lp1_c2_instruction, profile: 0
Enroll.create person: francisco_person, instruction: lp1_c2_instruction, profile: 0
Enroll.create person: leonardo_person, instruction: lp1_c2_instruction, profile: 0
Enroll.create person: ana_person, instruction: lp1_c2_instruction, profile: 0