# -*- coding: utf-8 -*-
from nltk.stem.snowball import SnowballStemmer
import math
import sys
import os
import psycopg2
reload(sys)
sys.setdefaultencoding('utf-8')

def getConnection():
	con = psycopg2.connect(host='database', database='server_development', user='server', password='123')
	return con

def selectCluster(presentation_id):
	cl = []
	clus = []
	con = getConnection()
	cur = con.cursor()
	sql = "SELECT id FROM Clusters WHERE presentation_id = " + str(presentation_id)
	cur.execute(sql)
	recset = cur.fetchall()
	for rec in recset:
		cl.append(rec[0])
	for c in cl:
		#sql = "SELECT Q.id , Q.text FROM Questions Q INNER JOIN Cluster_Questions CQ ON Q.id = CQ.question_id INNER JOIN Clusters C on C.id = CQ.cluster_id and C.id = "+str(c)
		sql = "SELECT Q.id, Q.text FROM Questions Q inner join clusters C ON Q.cluster_id = C.id and C.id = "+str(c)
		cur.execute(sql)
		recset = cur.fetchall()
		aux = []
		for rec in recset:
			dic = {"question_id":rec[0], "text":rec[1]}
			aux.append(dic)
		cluster = {'id':c, 'cluster':aux}
		clus.append(cluster)
	con.close()
	return clus

def getQuestion(id_presentation):
	con = getConnection()
	cur = con.cursor()
	sql = "SELECT id, text FROM questions WHERE presentation_id = "+str(id_presentation)+"and cluster_id is null"
	cur.execute(sql)
	quest = []
	recset = cur.fetchall()
	for rec in recset:
		quest.append((rec[0], rec[1]))
	con.close()
	return quest

def addQuestionToCluster(id_cluster,question):
	con = getConnection()
	cur = con.cursor()
	#sql = 'INSERT INTO Cluster_Questions(cluster_id, question_id) VALUES ('+str(id_cluster)+','+str(question)+')'
	sql = 'update questions set cluster_id = '+ str(id_cluster) +' where id = ' + str(question)
	cur.execute(sql)
	con.commit()

def addNewCluster(question, presentation_id):
	con = getConnection()
	cur = con.cursor()
	id = 0
	
	sql = 'INSERT INTO Clusters(presentation_id) VALUES('+str(presentation_id)+')'
	cur.execute(sql)
	con.commit()
	sql = 'SELECT max(id) FROM Clusters'
	cur.execute(sql)
	recset = cur.fetchall()
	for rec in recset:
		id = rec[0]
	#sql = 'INSERT INTO Cluster_Questions(cluster_id, question_id) VALUES('+str(id)+','+str(question)+')'
	sql = 'update questions set cluster_id = '+ str(id) +' where id = '+str(question)
	cur.execute(sql)
	con.commit()
	return id

def SWRemove(frase):
	frase = frase.lower()
	sw = 'a, agora, ainda, alguém, algum, alguma, algumas, alguns, ampla, amplas, amplo, amplos, ante, antes, ao, aos, após, aquela, aquelas, aquele, aqueles, aquilo, as, até, através, cada, coisa, coisas, com, como, contra, contudo, da, daquele, daqueles, das, de, dela, delas, dele, deles, depois, dessa, dessas, desse, desses, desta, destas, deste, deste, destes, deve, devem, devendo, dever, deverá, deverão, deveria, deveriam, devia, deviam, disse, disso, disto, dito, diz, dizem, do, dos, e, é, ela, elas, ele, eles, em, enquanto, entre, era, essa, essas, esse, esses, esta, está, estamos, estão, estas, estava, estavam, estávamos, este, estes, estou, eu, fazendo, fazer, feita, feitas, feito, feitos, foi, for, foram, fosse, fossem, grande, grandes, há, isso, isto, já, la, lá, lhe, lhes, lo, mas, me, mesma, mesmas, mesmo, mesmos, meu, meus, minha, minhas, muita, muitas, muito, muitos, na, não, nas, nem, nenhum, nessa, nessas, nesta, nestas, ninguém, no, nos, nós, nossa, nossas, nosso, nossos, num, numa, nunca, o, os, ou, outra, outras, outro, outros, para, pela, pelas, pelo, pelos, pequena, pequenas, pequeno, pequenos, per, perante, pode, pude, podendo, poder, poderia, poderiam, podia, podiam, pois, por, porém, porque, posso, pouca, poucas, pouco, poucos, primeiro, primeiros, própria, próprias, próprio, próprios, quais, qual, quando, quanto, quantos, que, quem, são, se, seja, sejam, sem, sempre, sendo, será, serão, seu, seus, si, sido, só, sob, sobre, sua, suas, talvez, também, tampouco, te, tem, tendo, tenha, ter, teu, teus, ti, tido, tinha, tinham, toda, todas, todavia, todo, todos, tu, tua, tuas, tudo, última, últimas, último, últimos, um, uma, umas, uns, vendo, ver, vez, vindo, vir, vos, vós'
	sws = []
	nf = []
	for p in sw.split(', '):
		sws.append(p)
	for f in frase.split(' '):
		nf.append(f)
	i = 0
	nv = []
	for p in nf:
		if p not in sws:
			nv.append(p)
		i = i+1
	stemmer = SnowballStemmer("portuguese")
	st = []
	fv = []
	for p in nv:
		pal = p.split(',')
		fv.append(pal[0])
	for p in fv:
		a = stemmer.stem(p)
		st.append(a)
	return st

def CalcFreq(frase):
	freq = []
	x = len(frase)
	k = 1
	i = 0
	while i < x:
		c = 1
		for j in range(k,x):
			if frase[i] == frase[j]:
				c+=1
		freq.append({'palavra':frase[i],'freq':c})
		k+=c
		i+=c
	return freq

def SepararFreq(v1,v2,f1,f2):
	if len(sorted(v1)) <= len(sorted(SWRemove(v2))):
		freq1 = CalcFreq(sorted(SWRemove(v2)))
		freq2 = CalcFreq(sorted(v1))
	else:
		freq1 = CalcFreq(sorted(v1))
		freq2 = CalcFreq(sorted(SWRemove(v2)))
	x = len(freq1)
	y = len(freq2)

	i = 0
	while i < x:
		if freq1[i] in freq2:
			f1.insert(i,freq1[i]['freq'])
			f2.insert(i,freq2[freq2.index(freq1[i])]['freq'])
		else:
			f1.insert(i,freq1[i]['freq'])
			f2.insert(i,0)
		if i < y and freq2[i] not in freq1:
			f1.insert(i,0)
			f2.insert(i,freq2[i]['freq'])
			
		i+=1

def CalcSimilaridade(v1,v2):
	f1 = []
	f2 = []
	SepararFreq(v1,v2,f1,f2)
	sim = 0
	somac = 0
	somabe = 0
	somabd = 0
	for i in range(0,len(f1)):
		somac += f1[i]*f2[i]
		somabe += f1[i]**2
		somabd += f2[i]**2
	
	sim = somac/(float((somabe*somabd)**0.5))

	return sim

def Cluster(listaCluster, sentencas,metodo, simMin, n, presentation_id):
	for sentenca in sentencas:
		itens = []
		sim = 0
		aux = 0
		index = 0
		if len(listaCluster) == 0:
			itens.append(sentenca)
			id = addNewCluster(itens[0]['id'], presentation_id)
			listaCluster.append({'id':id, 'cluster':itens})
		else:
			for c in listaCluster:
				if metodo == '-idf':
					centroid = gerarCentroid(c,sentencas,metodo,n)
				else:
					centroid = gerarCentroid(c,sentencas,metodo,n)
				sim = CalcSimilaridade(centroid , sentenca['text'])
				print(centroid, SWRemove(sentenca['text']))
				print(sim)
				if sim > aux:
					aux = sim
					index = listaCluster.index(c)
			if aux >= simMin:
				listaCluster[index]['cluster'].append(sentenca)
				addQuestionToCluster(listaCluster[index]['id'],sentenca['id'])
			else:
				itens.append(sentenca)
				id = addNewCluster(itens[0]['id'], presentation_id)
				listaCluster.append({'id':id, 'cluster':itens})
				
def gerarCentroid(cluster,sentencas,metodo,n):
	tcluster = []
	tsentencas = []
	centroid = []
	cent = []
	pcluster = []
	qtd = 0
	dicc = {}
	for c in cluster['cluster']:
		tcluster.append(SWRemove(c['text']))
	for s in sentencas:
		tsentencas.append(SWRemove(s['text']))

	for c in tcluster:
		for p in c:
			pcluster.append(p)
	pord = sorted(pcluster)
	pcluster = CalcFreq(pord)
	for p in pcluster:
		tf = p['freq']
		tscw = 1
		idf = 0
		for s in tsentencas:
			if(metodo == "-idf"):
				for palavra in s:
					if p['palavra'] == palavra:
						tscw += 1
						break
				if len(sentencas)/tscw > 0:
					idf = 1 + math.log((len(sentencas)/tscw))
				else:
					idf = 1
				tfidf = tf * idf
				dicc = {'palavra':p['palavra'],'value':tfidf}
			else:
				if len(sentencas)/tf > 0:
					idf = 1 + math.log((len(sentencas)/tf))
				else:
					idf = 1
				tfidf = tf * idf
				dicc = {'palavra':p['palavra'],'value':tfidf}
		centroid.append(dicc)
	cent = sorted(centroid, key=lambda k: k['value'])
	i = n
	centroid = []
	if len(cent) > n:
		while i > 0:
			if qtd < n:
				centroid.append(cent[i]['palavra'])
				qtd+=1
				i-=1
	else:
		for c in cent:
			centroid.append(c['palavra'])
	return centroid

# def CalcTFISF(cluster,sentencas,n):
# 	tcluster = []
# 	tsentencas = []
# 	centroid = []
# 	cent = []
# 	pcluster = []
# 	qtd = 0
# 	dicc = {}
# 	for c in cluster['cluster']:
# 		tcluster.append(SWRemove(c['text']))
# 	for s in sentencas:
# 		tsentencas.append(SWRemove(s['text']))

# 	for c in tcluster:
# 		for p in c:
# 			pcluster.append(p)
# 	pord = sorted(pcluster)
# 	pcluster = CalcFreq(pord)

# 	for p in pcluster:
# 		tf = p['freq']
# 		df = 0
# 		idf = 1 + math.log((len(sentencas)/tf))
# 		tfidf = tf * idf
# 		dicc = {'palavra':p['palavra'],'tf-isf':tfidf}
# 		centroid.append(dicc)
# 	cent = sorted(centroid, key=lambda k: k['tf-isf'])
# 	i = n
# 	centroid.clear()
# 	if len(cent) > n:
# 		while i > 0:
# 			if qtd < n:
# 				centroid.append(cent[i]['palavra'])
# 				qtd+=1
# 				i-=1
# 	else:
# 		for c in cent:
# 			centroid.append(c['palavra'])
# 	return centroid

def createCluster(metodo, lsim, tcen, sentencas, id_p):
	#seleciona as perguntas de cada cluster no banco
	cl = selectCluster(id_p)

	sentenca = []
	flag = 0
	for s in sentencas:
		for c in cl:
			for i in c['cluster']:
				if i['question_id'] == s[0]:
					flag = 1
					break
		if flag == 0:
			sentenca.append({'id':s[0],'text':s[1]})
		else:
			flag = 0
	Cluster(cl, sentenca, metodo, 0.4, 10, id_p)

if sys.argv[1] == '-idf':
	id_p = int(sys.argv[4])
	sentenca = getQuestion(id_p)
	createCluster('-idf',float(sys.argv[2]), int(sys.argv[3]), sentenca, id_p)
elif sys.argv[1] == '-isf':
	id_p = int(sys.argv[4])
	sentenca = getQuestion(id_p)
	createCluster('-isf',float(sys.argv[2]), int(sys.argv[3]), sentenca, id_p)
elif sys.argv[1] == '-visu':
	print(selectCluster(sys.argv[2]))
elif sys.argv[1] == '-h':
	print("-h help\n")
	print("Tente utilizar o comando:\n");
	print("python clustering.py metodo(-idf para TF-IDF ou -isf para TF-ISF) limiteSimilaridade(de 0 a 1) tamanhoCentroid idAula")
else:
	print("parametros errado, para ajuda utilize -h")

