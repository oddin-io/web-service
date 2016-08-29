# People
# ======================================================================================================================
silvana_affonso = Person.create name: 'Silvana Maria Affonso de Lara', email: 'silaffonso@ifsp.edu.br', password: '030771'
beatriz_maia = Person.create name: 'Beatriz Marques Maia', email: 'bia_mmaia@hotmail.com', password: '1601652'
bruno_batista = Person.create name: 'Bruno da Silveira Batista', email: 'brunobatista98@hotmail.com', password: '1601067'
bruno_avelino = Person.create name: 'Bruno de Souza Avelino', email: 'bruno_souza_avelino@hotmail.com', password: '1600478'
cendy_oliveira = Person.create name: 'Cendy Andreoli de Oliveira', email: 'cendyandreoli@gmail.com', password: '1601741'
edipo_lohmann = Person.create name: 'Edipo Luiz Lohmann', email: 'edipo.rh@gmail.com', password: '1600281'
estevao_lourenco = Person.create name: 'Estevao Ferreira Lourenco', email: 'estevaofl@live.com', password: '1600991'
ezequiel_junior = Person.create name: 'Ezequiel Sant Ana Junior', email: 'eskiel.sj@gmail.com', password: '1301047'
gabriel_silva = Person.create name: 'Gabriel Catice da Silva', email: 'gabriel.catice@icloud.com', password: '1600354'
hiago_souza = Person.create name: 'Hiago Rafael de Souza', email: 'hiago.rafael.souza@hotmail.com', password: '1600559'
hugo_ciarrocchi = Person.create name: 'Hugo Saldanha Ciarrocchi', email: 'hugoabstrato@gmail.com', password: '160046X'
joel_ruivo = Person.create name: 'Joel Rodrigues Ruivo', email: 'joel.rodrigues.09@hotmail.com', password: '1600346'
joyce_trindade = Person.create name: 'Joyce Nathalia de Souza Trindade', email: 'joycenathalia@gmail.com', password: '1600389'
katio_pequeno = Person.create name: 'Katio de Almeida Pequeno', email: 'katioalmeida@gmail.com', password: '110246X'
lucas_melo = Person.create name: 'Lucas Ferreira Melo', email: 'lucasferreiramelo@outlook.com', password: '1402064'
matheus_braz = Person.create name: 'Matheus Mendes Braz', email: 'mattmbraz@hotmail.com', password: '1102028'
monica_pelicano = Person.create name: 'Monica Lourenco Gomes Pelicano', email: 'monica_pelicano@hotmail.com', password: '1600591'
nayly_carvalho = Person.create name: 'Nayly Muniz Carvalho', email: 'nayly-rc@hotmail.com', password: '1301179'
paulo_fios = Person.create name: 'Paulo Henrique Fios', email: 'paulohenriquefios@outlook.com', password: '1601687'
rafael_brito = Person.create name: 'Rafael de Campos Brito', email: 'rafaelbrito144@gmail.com', password: '1601695'
renato_aldrighi = Person.create name: 'Renato Aldrighi', email: 'renato.aldrighi@gmail.com', password: '160032X'
ricardo_carvalho = Person.create name: 'Ricardo de Carvalho', email: 'ricardo.tks.best@gmail.com', password: '1600427'
rodrigo_silva = Person.create name: 'Rodrigo Hideo Tanaka da Silva', email: 'rodrigorhts@hotmail.com', password: '1601091'
thon_ataide = Person.create name: 'Thon Christopher Ataide', email: 'thon_ataide10@hotmail.com', password: '150102X'
willian_correa = Person.create name: 'Willian Toshio Nogiri Correa', email: 'willianthoshio14@gmail.com', password: '1401891'
yudji_oliveira = Person.create name: 'Yudji Nakaema Oliveira', email: 'yudjiii@gmail.com', password: '160161X'
jeanderson_nascimento = Person.create name: 'Jeanderson Lineker do Nascimento', email: 'jeandersonlineker@gmail.com', password: '1600745'

bruno_trevisan = Person.create name: 'Bruno Trevisan', email: 'bruno.trevisan@email.com', password: '160077X'
carolina_sartorelli = Person.create name: 'Carolina Sartorelli',email: 'carolina.sartorelli@email.com', password: '1201484'
isabella_silva = Person.create name: 'Isabella Cristina Gomes da Silva', email: 'isabella.silva@email.com', password: '1504045'
lucas_silva = Person.create name: 'Lucas Marques da Silva', email: 'lucas.silva@email.com', password: '1000322'
luciano_ferreira = Person.create name: 'Luciano Tochio Ferreira', email: 'luciano.ferreira@email.com', password: '1600648'
marcelo_oliveira = Person.create name: 'Marcelo Gomes de Oliveira', email: 'marcelo.oliveira@email.com', password: '1401971'
pedro_santos = Person.create name: 'Pedro Henrique Dos Santos', email: 'pedro.santos@email.com', password: '150357X'
tiago_spana = Person.create name: 'Tiago Spana', email: 'tiago.spana@email.com', password: '1301781'

# Events
# ======================================================================================================================
ads = Event.create code: 'ADS', name: 'Tecnologia em Análise e Desenvolvimento de Sistemas', workload: 2100.7

# Lectures
# ======================================================================================================================
bd1 = Lecture.create code: 'BD1', name: 'Banco de Dados I', workload: 79.2

# Instructions
# ======================================================================================================================
bd1_instruction = Instruction.create event: ads , lecture: bd1, class_number: 1, start_date: '2015-07-28', end_date: '2015-12-22'

# Enrolls
# ======================================================================================================================
Enroll.create person: silvana_affonso, instruction: bd1_instruction, profile: 1
Enroll.create person: beatriz_maia, instruction: bd1_instruction, profile: 0
Enroll.create person: bruno_batista, instruction: bd1_instruction, profile: 0
Enroll.create person: bruno_avelino, instruction: bd1_instruction, profile: 0
Enroll.create person: bruno_trevisan, instruction: bd1_instruction, profile: 0
Enroll.create person: carolina_sartorelli, instruction: bd1_instruction, profile: 0
Enroll.create person: cendy_oliveira, instruction: bd1_instruction, profile: 0
Enroll.create person: edipo_lohmann, instruction: bd1_instruction, profile: 0
Enroll.create person: estevao_lourenco, instruction: bd1_instruction, profile: 0
Enroll.create person: ezequiel_junior, instruction: bd1_instruction, profile: 0
Enroll.create person: gabriel_silva, instruction: bd1_instruction, profile: 0
Enroll.create person: hiago_souza, instruction: bd1_instruction, profile: 0
Enroll.create person: hugo_ciarrocchi, instruction: bd1_instruction, profile: 0
Enroll.create person: isabella_silva, instruction: bd1_instruction, profile: 0
Enroll.create person: joel_ruivo, instruction: bd1_instruction, profile: 0
Enroll.create person: joyce_trindade, instruction: bd1_instruction, profile: 0
Enroll.create person: katio_pequeno, instruction: bd1_instruction, profile: 0
Enroll.create person: lucas_melo, instruction: bd1_instruction, profile: 0
Enroll.create person: lucas_silva, instruction: bd1_instruction, profile: 0
Enroll.create person: luciano_ferreira, instruction: bd1_instruction, profile: 0
Enroll.create person: marcelo_oliveira, instruction: bd1_instruction, profile: 0
Enroll.create person: matheus_braz, instruction: bd1_instruction, profile: 0
Enroll.create person: monica_pelicano, instruction: bd1_instruction, profile: 0
Enroll.create person: nayly_carvalho, instruction: bd1_instruction, profile: 0
Enroll.create person: paulo_fios, instruction: bd1_instruction, profile: 0
Enroll.create person: pedro_santos, instruction: bd1_instruction, profile: 0
Enroll.create person: rafael_brito, instruction: bd1_instruction, profile: 0
Enroll.create person: renato_aldrighi, instruction: bd1_instruction, profile: 0
Enroll.create person: ricardo_carvalho, instruction: bd1_instruction, profile: 0
Enroll.create person: rodrigo_silva, instruction: bd1_instruction, profile: 0
Enroll.create person: thon_ataide, instruction: bd1_instruction, profile: 0
Enroll.create person: tiago_spana, instruction: bd1_instruction, profile: 0
Enroll.create person: willian_correa, instruction: bd1_instruction, profile: 0
Enroll.create person: yudji_oliveira, instruction: bd1_instruction, profile: 0
Enroll.create person: jeanderson_nascimento, instruction: bd1_instruction, profile: 0
