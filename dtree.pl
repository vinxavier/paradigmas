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

% Mostra a resposta e encerra programa
respencerra(X,Y) :-
	format("A resposta foi ~w. ~n ~n",[X]),
	encerra(Y).

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
	

	

%%%%%%%%%%%%%%%%%%%%%%
% Raiz da arvore
%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%
% Nível 1 da arvore
%%%%%%%%%%%%%%%%%%%%%%
	
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
	respperg("SIM", "Early Uptake"),
	opcbinaria,
	get_single_char(C), earlyuptake1(C).
	
bypass2(Other) :-
	digitedenovo,
	get_single_char(C), bypass2(C).

%%%%%%%%%%%%%%%%%%%%%%
% Nível 2 da arvore
%%%%%%%%%%%%%%%%%%%%%%

% dislocation1 quando bypass1 é nao
dislocation1(49) :-
	respperg("NAO", "Block of Affere"),
	opcbinaria,
	get_single_char(C), blockofaffere1(C).

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
	get_single_char(C), blockofaffere2(C).

dislocation2(50) :-
	respperg("NAO", "Lymphatics"),
	opcquaternaria("Normal","Arched","Deformed","Displaced"),
	get_single_char(C), lymphatics1(C).

dislocation2(Other) :-
	digitedenovo,
	get_single_char(C), dislocation2(C).

% earlyuptake1 quando bypass2 é sim
earlyuptake1(49) :-
	respperg("NAO", "Bl. of Lymph. S"),
	opcbinaria,
	get_single_char(C), bllymphs(C).

earlyuptake1(50) :-
	respperg("SIM", "Regeneration of"),
	opcbinaria,
	get_single_char(C), regeneration(C).

earlyuptake1(Other) :-
	digitedenovo,
	get_single_char(C), earlyuptake1(C).

%%%%%%%%%%%%%%%%%%%%%%
% Nível 3 da arvore
%%%%%%%%%%%%%%%%%%%%%%

% blockofaffere1 quando dislocation1 é não
blockofaffere1(49) :-
	respperg("NAO", "Exclusion Of Nodes"),
	opcbinaria,
	get_single_char(C), exclusion2(C).

blockofaffere1(50) :-
	respperg("SIM", "Early Uptake"),
	opcbinaria,
	get_single_char(C), earlyuptake2(C).

blockofaffere1(Other) :-
	digitedenovo,
	get_single_char(C), blockofaffere1(C).

% blockofaffere2 quando dislocation2 é Não
blockofaffere2(49) :-
	write("A resposta foi NAO"),nl,nl,
	encerra(4).

blockofaffere2(50) :-
	respencerra("SIM", 2).

blockofaffere2(Other) :-
	digitedenovo,
	get_single_char(C), blockofaffere2(C).

% bllymphs caso earlyuptake1 seja nao
bllymphs(49) :-
	write("A resposta foi NAO"),nl,nl,
	encerra(2).

bllymphs(50) :-
	respencerra("SIM", 4).

bllymphs(Other) :-
	digitedenovo,
	get_single_char(C), bllymphs(C).

% exclusion1 quando dislocation1 é sim
exclusion1(49) :-
	respperg("NAO", "Lymphatics"),
	opcquaternaria("Normal","Arched","Deformed","Displaced"),
	get_single_char(C), lymphatics2(C).

exclusion1(50) :-
	respperg("SIM", "Early Uptake"),
	opcbinaria,
	get_single_char(C), earlyuptake3(C).

exclusion1(Other) :-
	digitedenovo,
	get_single_char(C), exclusion1(C).

% lymphatics1 caso dislocation2 seja sim
lymphatics1(49):-
	respencerra("Normal", 0).

lymphatics1(50):-
	respencerra("Arched", 0).

lymphatics1(51):-
	respencerra("Deformed", 3).

lymphatics1(52):-
	respencerra("Displaced", 2).

lymphatics1(Other):-
	digitedenovo,
	get_single_char(C), lymphatics1(C).

% regeneration caso earlyuptake1 seja sim
regeneration(49) :-
	respencerra("NAO", 2).

regeneration(50) :-
	respencerra("SIM", 3).

regeneration(Other) :-
	digitedenovo,
	get_single_char(C), regeneration(C).

%%%%%%%%%%%%%%%%%%%%%%
% Nível 4 da arvore
%%%%%%%%%%%%%%%%%%%%%%

% exclusion2 caso blackofaffere1 seja não
exclusion2(49) :-
	respencerra("NAO", 1).

exclusion2(50) :-
	respperg("SIM", "Extravasates"),
	opcbinaria,
	get_single_char(C), extravasates1(C).

exclusion2(Other) :-
	digitedenovo,
	get_single_char(C), exclusion2(C).

% earlyuptake2 quando blockofaffere1 é sim
earlyuptake2(49):-
	respencerra("NAO", 2).

earlyuptake2(50):-
	respperg("SIM", "Exclusion of"),
	opcbinaria,
	get_single_char(C), exclusion3(C).

earlyuptake2(Other):-
	digitedenovo,
	get_single_char(C), earlyuptake2(C).

% lymphatics2 caso exclusion1 seja não
lymphatics2(49):-
	respencerra("Normal", 0).

lymphatics2(50):-
	respencerra("Arched", 2).

lymphatics2(51):-
	respencerra("Deformed", 0).

lymphatics2(52):-
	respencerra("Displaced", 3).

lymphatics2(Other):-
	digitedenovo,
	get_single_char(C), lymphatics2(C).

% earlyuptake3 quando exclusion1 é sim
earlyuptake3(49):-
	respperg("NAO", "Lymphatics"),
	opcquaternaria("Normal","Arched","Deformed","Displaced"),
	get_single_char(C), lymphatics3(C).

earlyuptake3(50):-
	respperg("SIM", "Extravasates"),
	opcbinaria,
	get_single_char(C), extravasates2(C).

earlyuptake3(Other):-
	digitedenovo,
	get_single_char(C), earlyuptake3(C).

%%%%%%%%%%%%%%%%%%%%%%
% Nível 5 da arvore
%%%%%%%%%%%%%%%%%%%%%%

% exclusion3 caso earlyuptake2 seja sim
exclusion3(49) :-
	respencerra("NAO", 2).

exclusion3(50) :-
	respperg("SIM", "Extravasates"),
	opcbinaria,
	get_single_char(C), extravasates3(C).

exclusion3(Other) :-
	digitedenovo,
	get_single_char(C), exclusion3(C).

% extravasets1 caso exclusion2 seja sim
extravasates1(49) :-
	respencerra("NAO", 2).

extravasates1(50) :-
	respencerra("SIM", 3).

extravasates1 :-
	digitedenovo,
	get_single_char(C), extravasates1(C).

% extravasets2 caso earlyuptake3 seja sim
extravasates2(49) :-
	respperg("NAO", "Special Forms"),
	writef("\t 1 - No"), nl,
	writef("\t 2 - Chalices"), nl,
	writef("\t 3 - Vesicles"), nl,
	get_single_char(C), specialforms(C).

extravasates2(50) :-
	respperg("NAO", "Block of Affere"),
	opcbinaria,
	get_single_char(C), blockofaffere3(C).

extravasates2 :-
	digitedenovo,
	get_single_char(C), extravasates2(C).

% lymphatics3 quando earlyuptake3 for nao
lymphatics3(49):-
	respencerra("Normal", 0).

lymphatics3(50):-
	respencerra("Arched", 2).

lymphatics3(51):-
	respencerra("Deformed", 3).

lymphatics3(52):-
	respencerra("Displaced", 0).

lymphatics3(Other):-
	digitedenovo,
	get_single_char(C), lymphatics3(C).

%%%%%%%%%%%%%%%%%%%%%%
% Nível 6 da arvore
%%%%%%%%%%%%%%%%%%%%%%
% extravasates3(é igual o extravasates1) caso exclusion3 seja sim
extravasates3(49):-
	extravasates1(49).

extravasates3(50):-
	extravasates1(50).

extravasates3(Other):-
	extravasates1(Other).

% specialforms caso extravasets2 seja nao
specialforms(49):-
	respperg("NO", "Number of nodes"),
	writef("\t 1 - (0 - 9)"), nl,
	writef("\t 2 - (10 - 19)"), nl,
	writef("\t 3 - (>=20)"), nl,
	get_single_char(C), nofnodes(C).

specialforms(50):-
	respencerra("Chalices", 2).

specialforms(51):-
	respencerra("Vasicles", 0).

specialforms(Other):-
	digitedenovo,
	get_single_char(C), specialforms(C).

% blockofaffere3 caso extravasets2 seja sim
blockofaffere3(49):-
	respencerra("NAO", 3).

blockofaffere3(50):-
	respperg("NAO", "Changes in Structure"),
	writef("\t 1 - No, Grainy, Drop-like, Coarse, Reticular or Stripped"), nl,
	writef("\t 2 - Diluted"), nl,
	writef("\t 3 - Faint"), nl,
	get_single_char(C), changesinstructure(C).

blockofaffere3(Other):-
	digitedenovo,
	get_single_char(C), blockofaffere3(C).


%%%%%%%%%%%%%%%%%%%%%%
% Nível 7 da arvore
%%%%%%%%%%%%%%%%%%%%%%

% nofnodes caso specialforms seja No
nofnodes(49):-
	respencerra("(0-9)",2).

nofnodes(50):-
	respencerra("(10-19)",3).

nofnodes(51):-
	respencerra("(>=20)",0).

nofnodes(Other):-
	digitedenovo,
	get_single_char(C), nofnodes(C).

% changesinstructure quando blockofaffere3 é não
changesinstructure(49):-
	respencerra("No, Grainy, Drop-like, Coarse, Reticular or Stripped",0).

changesinstructure(50):-
	respencerra("Diluted",3).

changesinstructure(51):-
	respencerra("Faint",2).

changesinstructure(Other):-
	digitedenovo,
	get_single_char(C), changesinstructure(C).
