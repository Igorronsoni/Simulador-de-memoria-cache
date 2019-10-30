.data
cache: .word -1,-1
armazenamento: .word 0,0

.text

initialization:
	#contador do cache
	add t3,zero,zero
	#contador da pilha
	add t4,zero,zero
	#contador de deu
	add t5,zero,zero
	#ponteiro do armazenamento
	la s10,armazenamento
	#ponteiro da pilha
	la s11,cache
	#armazena um e dois
	addi s8,zero,1
	addi s9,zero,2
	#dois valores da pilha e o resultado
	addi a0,zero,7
	addi a1,zero,3
	addi a2,zero,-1
	#dois valores atuais e o resultado
	add a5,zero,zero
	add a6,zero,zero
	add a7,zero,zero
	#dois valores primeira função e o resultado
	add s2,zero,zero
	add s3,zero,zero
	add s4,zero,zero
	#dois valores segunda função
	add s5,zero,zero
	add s6,zero,zero
	add s7,zero,zero
	#saida
	add s0,zero,zero
	jal init
	jal init
	j end
init:
	addi t4,t4,1
	sw a0,0(s10)
	sw a1,4(s10)
	sw ra,8(s10)
	addi s10,s10,12
init2:
	sw a0,0(s10)
	sw a1,4(s10)
	sw ra,8(s10)
	addi s10,s10,12
	jal leitor
	
leitor:

	#primeiro valor
	
	addi s2,a0,-1 # n-1
	add s3,a1,zero # k

	
	# n == k                ->   1
	# n < 1   OR    k < 1   ->   0
	# n == 1  AND   k > 1   ->   0
	beq s2,s3,contaUm
	#bge s4,s8,contaDeu
	j leitor2
	
leitor2:
	blt s2,s8,contaZero
	blt s3,s8,contaZero
	j leitor3
	
leitor3:
	beq s2,s8,verificaK
	beq s3,s8,contaUm
	j nenhumaCondicao	

contaUm: 
	addi s4,zero,1
	contaDeu:
	addi t5,t5,1
	j algumaCondicao
	
verificaK:
	bgt s3,s8,contaZero
	j algumaCondicao

nenhumaCondicao:
	bgt t3,zero,loadCache
	j addPilha
	
	loadCache:
	la t0,cache
	add t1,zero,zero
	loadCacheBegin:
	add t1,t1,s8
	bgt t1,t3,addPilha
	lw a5,4(t0)
	lw a6,0(t0)
	lw a7,-4(t0)
	addi t0,t0,-12
	beq s2,a5,andCompara
	j loadCacheBegin
	
	andCompara:
	beq s3,a6,foundCache
	j loadCacheBegin
	
	foundCache:
	add s4,zero,a7
	addi t5,t5,1
	j algumaCondicao
	
	addPilha:
	addi t4,t4,1
	sw s2,0(s10)
	sw s3,4(s10)
	sw ra,8(s10)
	addi s10,s10,12
	j segundaFuncao
	
	#nenhuma condição
	#le cache
	#se não tem, conta 1 na pilha e armazena o valor
algumaCondicao:
	j segundaFuncao
	
	
contaZero:
	add s4,zero,zero
	addi t5,t5,1
	

leitor4:
	bge t5,s9,ok
	j end
	
segundaFuncao:

	addi s5,a0,-1 # n-1
	addi s6,a1,-1 # k-1

	# n == k                ->   1
	# n < 1   OR    k < 1   ->   0
	# n == 1  AND   k > 1   ->   0
	
	beq s5,s6,contaUm2
	j segundaFuncao2
	
segundaFuncao2:
	blt s5,s8,contaZero2
	blt s6,s8,contaZero2
	j segundaFuncao3

segundaFuncao3:
	beq s5,s8,verificaK2
	beq s6,s8,contaUm2
	j nenhumaCondicao2	

contaUm2: 
	addi s7,zero,1
	addi t5,t5,1
	j algumaCondicao2
	
verificaK2:
	bgt s5,s8,contaZero2
	j algumaCondicao2
	
contaZero2:
	add s4,zero,zero
	addi t5,t5,1
	j algumaCondicao2
	
algumaCondicao2:
	j deuOuNao
	
nenhumaCondicao2:
	bgt t3,zero,loadCache2
	j addPilha2
	
	loadCache2:
	la t0,cache
	add t1,zero,zero
	loadCacheBegin2:
	add t1,t1,s8
	bgt t1,t3,addPilha2
	lw a5,4(t0)
	lw a6,0(t0)
	lw a7,-4(t0)
	addi t0,t0,-12
	beq s5,a5,andCompara2
	j loadCacheBegin2
	
	andCompara2:
	beq s6,a6,foundCache2
	j loadCacheBegin2
	
	foundCache2:
	add s7,zero,a7
	addi t5,t5,1
	j algumaCondicao2
	
	addPilha2:
	addi t4,t4,1
	sw s5,0(s10)
	sw s6,4(s10)
	sw ra,8(s10)
	addi s10,s10,12
	
deuOuNao:
	blt t5,s9,naoDeu
	j deu
naoDeu:
	add t5,zero,zero
	lw a0,-12(s10)
	lw a1,-8(s10)
	lw ra,-4(s10)
	add s0,zero,a2
	j leitor
	
deu:
	mul a2,s4,a1
	add a2,a2,s7
	sw a0,4(s11)
	sw a1,0(s11)
	sw a2,-4(s11)
	addi t3,t3,1
	addi s11,s11,-12
	addi t4,t4,-1
	addi s10,s10,-12
	lw a0,-12(s10)
	lw a1,-8(s10)
	lw ra,-4(s10)
	add t5,zero,zero
	ret
ok:	
end:
	nop #aced parcero