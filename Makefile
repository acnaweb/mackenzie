run1:
	echo Teste

run2:
	echo AC; \
	echo Linha 2; \
	bash scripts/script1.sh; \

tudo: run1 run2
	echo Acabou


