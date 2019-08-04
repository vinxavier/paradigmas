% A função que irá iniciar o programa
init :-
	write("Esse aplicativo ira te auxiliar com o exame de linfografia, para isso, por favor responda as perguntas a seguir de acordo as instrucoes."),nl,nl,
	write("___________________________________INICIO___________________________________"),nl,nl,
	write("Digite o numero correspondente a opcao para B. of Lymph C:"),nl,
	opcbinaria,
	get_single_char(C), bllymphc(C).
	
% Requisição quando a entrada é inválida
digitedenovo :-
	write("Erro, a entrada nao e aceitavel"),nl,
	write("Digite novamente a resposta: "),nl.

% Mostrar duas opcoes sim e nao	
opcbinaria :-
	writef("\t 1 - Nao."),nl,
	writef("\t 2 - Sim."),nl.

% Quando há 4 opcoes :-
opcquaternaria(A, B, C, D) :-
	writef("\t 1 - %w.", [A]), nl,
	writef("\t 2 - %w.", [B]), nl,
	writef("\t 3 - %w.", [C]), nl,
	writef("\t 4 - %w.", [D]), nl.
	
% Mostra a resposta e pede a proxima pergunta
respperg(X, Y) :-
	format("A resposta foi ~w. ~n ~n Digite o numero correspondente a opcao para ~w: ~n", [X,Y]).

% Encerra a execução do programa
encerra(X) :-
	nl, write("________________________________DIAGNOSTICO:________________________________"), nl,nl,nl,
	diagnostico(X), nl,nl,nl,
	write("____________________________________FIM____________________________________"), nl.

diagnostico(1) :-
	write("################## A CONDICAO DO PACIENTE EH NORMAL ##################").

diagnostico(2) :- 
	write("################## A CONDICAO DO PACIENTE EH METASTASES ##################").

diagnostico(3) :-
	write("################## A CONDICAO DO PACIENTE EH LINFO MALIGNO ##################").

diagnostico(4) :-
	write("################## A CONDICAO DO PACIENTE EH FIBROSE ##################").

diagnostico(Other) :-
	write("################## IMPOSSIVEL DE DETERMINAR ##################").
	

% Verifica o código digitado na ASCII, valor de ASCII de 1 é 49, e de 2 é 50.
% As chamadas de by pass iria seguir para um rumo diferente na arvore de acordo com a resposta da primeira pergunta, 
% logo precisamos diferenciar com 1 e 2.	
bllymphc(49) :-
	respperg("NAO", "By Pass"),
	opcbinaria,
	get_single_char(C), bypass1(C).	
	
bllymphc(50) :-
	respperg("SIM", "By Pass"),
	opcbinaria,
	get_single_char(C), bypass2(C).
	
bllymphc(Other) :-
	digitedenovo,
	get_single_char(C), bllymphc(C).
	
% bypass1, quando bllymphc é nao.
bypass1(49) :-
	respperg("NAO", "Dislocation Of"),
	opcbinaria,
	get_single_char(C), dislocation1(C).

bypass1(50) :-
	respperg("SIM", "Dislocation Of"),
	opcbinaria,
	get_single_char(C), dislocation2(C).

bypass1(Other) :-
	digitedenovo,
	get_single_char(C), bypass1(C).

% bypass2, quando bllymphc é sim.
bypass2(49) :-
	write("A resposta foi NAO"),nl,nl,
	encerra(2).

bypass2(50) :-
	respperg("SIM", "Early Uptake of"),
	opcbinaria,
	get_single_char(C), earlyuptake1(C).
	
bypass2(Other) :-
	digitedenovo,
	get_single_char(C), bypass2(C).

% dislocation1 quando bypass1 é nao
dislocation1(49) :-
	% TODO : implementar
	encerra(0).

dislocation1(50) :-
	respperg("SIM", "Exclusion Of Nodes"),
	opcbinaria,
	get_single_char(C), exclusion1(C).

dislocation1(Other) :-
	digitedenovo,
	get_single_char(C), dislocation1(C).

% dislocation2 quando bypass1 é sim
dislocation2(49) :-
	respperg("NAO", "Block of Affere"),
	opcbinaria,
	get_single_char(C), blockofaffere1(C).

dislocation2(50) :-
	write("A resposta foi SIM"),nl,nl,
	opcquaternaria("Normal","Arched","Deformed","Displaced"),
	get_single_char(C), lymphatics1(C).

dislocation2(Other) :-
	digitedenovo,
	get_single_char(C), dislocation2(C).

% earlyuptake1 quando bypass2 é sim
earlyuptake1(49) :-
	respperg("NAO", " Bl. of Lymph. S"),
	opcbinaria,
	get_single_char(C), bllymphs(C).

earlyuptake1(50) :-
	respperg("SIM", "Regeneration of"),
	opcbinaria,
	get_single_char(C), regeneration(C).

earlyuptake1(Other) :-
	digitedenovo,
	get_single_char(C), earlyuptake1(C).

% exclusion1 quando dislocation1 é sim
exclusion1(49) :-
	respperg("NAO", "Lymphatics"),
	opcquaternaria("Normal","Arched","Deformed","Displaced"),
	get_single_char(C), lymphatics2(C).

exclusion1(50) :-
	respperg("SIM", "Early Uptake of"),
	opcbinaria,
	get_single_char(C), earlyuptake2(C).

exclusion1(Other) :-
	digitedenovo,
	get_single_char(C), exclusion1(C).

% blockofaffere1 quando dislocation2 é Não
blockofaffere1(49) :-
	write("A resposta foi NAO"),nl,nl,
	encerra(4).

blockofaffere1(50) :-
	write("A resposta foi SIM"),nl,nl,
	encerra(2).

blockofaffere1(Other) :-
	digitedenovo,
	get_single_char(C), blockofaffere1(C).

% bllymphs caso earlyuptake1 seja nao
bllymphs(49) :-
	write("A resposta foi NAO"),nl,nl,
	encerra(2).

bllymphs(50) :-
	write("A resposta foi SIM"),nl,nl,
	encerra(4).

bllymphs(Other) :-
	digitedenovo,
	get_single_char(C), bllymphs(C).

% regeneration caso earlyuptake1 seja sim
regeneration(49) :-
	write("A resposta foi NAO"),nl,nl,
	encerra(2).

regeneration(50) :-
	write("A resposta foi SIM"),nl,nl,
	encerra(3).

regeneration(Other) :-
	digitedenovo,
	get_single_char(C), regeneration(C).

% lymphatics1 caso dislocation2 seja sim
lymphatics1(49):
	write("A resposta foi Normal"),nl,nl,
	encerra(0).

lymphatics1(50):
	write("A resposta foi Arched"),nl,nl,
	encerra(0).

lymphatics1(51):
	write("A resposta foi Deformed"),nl,nl,
	encerra(3).

lymphatics1(52):
	write("A resposta foi Displaced"),nl,nl,
	encerra(2).

lymphatics1(Other):
	digitedenovo,
	get_single_char(C), lymphatics1(C).

% lymphatics2 caso exclusion1 seja não
lymphatics2(49):
	write("A resposta foi Normal"),nl,nl,
	encerra(0).

lymphatics2(50):
	write("A resposta foi Arched"),nl,nl,
	encerra(2).

lymphatics2(51):
	write("A resposta foi Deformed"),nl,nl,
	encerra(0).

lymphatics2(52):
	write("A resposta foi Displaced"),nl,nl,
	encerra(3).

lymphatics2(Other):
	digitedenovo,
	get_single_char(C), lymphatics2(C).

% earlyuptake2 quando exclusion1 é sim
earlyuptake2(49):
	respperg("NAO", "Lymphatics"),
	opcquaternaria("Normal","Arched","Deformed","Displaced"),
	get_single_char(C), lymphatics3(C).

earlyuptake2(50):
	respperg("SIM", "Extravasates"),
	opcbinaria,
	get_single_char(C), extravasates(C).

earlyuptake2(Other):
	digitedenovo,
	get_single_char(C), earlyuptake2(C).

% lymphatics2 quando earlyuptake2 for nao
lymphatics3(49):
	write("A resposta foi Normal"),nl,nl,
	encerra(0).

lymphatics3(50):
	write("A resposta foi Arched"),nl,nl,
	encerra(2).

lymphatics3(51):
	write("A resposta foi Deformed"),nl,nl,
	encerra(3).

lymphatics3(52):
	write("A resposta foi Displaced"),nl,nl,
	encerra(0).

lymphatics3(Other):
	digitedenovo,
	get_single_char(C), lymphatics3(C).

% extravasates caso earlyuptake2 for sim
