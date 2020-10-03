# AppManutencao

Projeto destinado à avaliação de contratação para equipe de Sustentação - Softplan. 
Siga as instruções descritas aqui para corrigir o projeto e entregar as correções para o avaliador.

Versão utilizada do Delphi: Tokyo 10.2. Pode ser utilizada outras versões, desde que o código seja compatível. 
Testamos com o Community 10.3 e funcionou também.

## Instruções

### Correções a serem realizadas

- Resolva todos defeitos descritos na seção `Defeitos`. Obrigatório.
- **Todos** os `hints` e `warnings` do projeto devem ser resolvidos. Não esqueça de sempre rodar o build (Shift + F9), ao invés do compile (Ctrl + F9), para ver todos os hints e warnings. Obrigatório.
- **Todos** os `memory leaks` do projeto devem ser resolvidos. Obrigatório.
- Fica aberto ao candidato se quiser refatorar algo no projeto. Opcional.

### Como submeter uma correção 

 - Corrija o projeto e nos envie por e-mail ou faça upload para núvem e nos envie o link. 
 - Envie o projeto limpo, apenas com os mesmos arquivos enviados (sem dcu, binário, etc).

## Defeitos

Corrija cada defeito descrito abaixo. Cada seção corresponde à uma tela do projeto. 
Para cada defeito, preencher causa e solução: 

* Causa: explicar tecnicamente qual era a causa do problema; 
* Solução: explicar tecnicamente qual foi a solução dada ao problema; 

### Dataset Copy 

`Defeito 1: fazer as alterações do Dataset 1 serem replicadas automaticamente no Dataset 2`

Causa: Não existia nenhuma rotina para replicar as alterações.

Solução: Foi criado uma Procedure UpdateDataSet2; o qual replica todas as alterações feitas no dataset1. 
         Essa rotina é instanciada na Criação do DataSet1 e Chamada após qualquer alteração. 

### Dataset Loop

`Defeito 2: corrigir rotina que apaga números pares`

Causa: Os valores pares estavam em ordem aleatória com os numeros impares, toda vez que um numero para era excluido 
       o cursor saltava 2 registros quando o NEXT era acionado.

Solução: Apenas fiz com que, a cada numero par excluído, o cursor retorne ao registro anterior, assim nao há riscos de não apagar os numeros pares

### Streams

`Defeito 3: erro de Out of Memory ao clicar no botão "Load 100"`

Causa: Erro de memoria, a function 'LoadStream' estava criado vários objetos TMemoryStream, instanciando em um mesmo objeto dentro do
       FOR, sem esvaziar da memoria.

Solução: Instanciar o objeto 'S' fora do FOR 

`Defeito 4: quando clica várias vezes seguidas no botão Load 100 (mais de 10 vezes), ao tentar fechar o sistema ele não fecha`

Causa: Ao Clicar várias vezes no Butão Load 100, a Thread principal enfileira o processamento, dificultando assim o fechamento,
       era necessário esperar a execução de todos os processos para poder fechar a tela. 

Solução: Ao Clicar Butão Load 100, desabilitei o mesmo, para evitar que esse processo seja enfileirado na thread. Assim cada processo será 
         executado por sua vez, ao termino o butão será ativado para outro processamento, impedindo assim a grande alocamento de memoria e 
         a lentidão ao fechar o programa.

### Exceptions/Performance

`Defeito 5: melhorar performance do processamento quando utilizado o botão "Operação em lote". 
            Esperado que a operação seja concluída em menos de 10s. (Manter a ordem original do texto é um plus)`

Causa: O uso do FOR para remover caracteres diminue a performance da aplicação.

Solução: Remover o FOR e utilizar StringReplace, para remover o numero enviado pela rotina. Dessa forma não mexemos na sua organização e sequencia.

`Defeito 6: ao clicar no botão "Operação 1" está escondendo a exceção original. Alterar para mostrar a exceção correta no Memo1`

Causa: A Procedure LoadNumbers tem uma Exception genérica que força uma Raise, como a rotina que dá start a este procedimento
       também contem uma Exception genérica, e está no final do processamento, logo, também será chamada subscrevendo a exceção original.

Solução: Removi o Raise da exceção Original, colocando as informações em uma Lista Genérica que no final do processo armazenará no Memo1.
         Sem o Raise sendo acionado, a exceção é silênciada para não forçar as Exceptions em Cadeia.

`Defeito 7: ao clicar em "Operação em lote" não deve parar o processamento caso dê erros na rotina. 
            Caso apresente erros, suas classes (ClassName da exceção) e mensagens (Message da exceção) 
			devem ser mostrados no fim do processamento, no Memo1. Exemplo: é feito um laço de 0 à 7. 
			Caso dê erro quando i for igual a 1, deve continuar o processamento para o 2, e assim por diante.`

Causa: O raise estava parando o processo.

Solução: Removi o raise e fiz a adição das linhas de erro em uma lista generica, ao fim do processo, 
         se houver erro ele mostra no memo1. ( A resolução "Defeito 5", eliminou os exceptions do bloco, 
		                                       então fiz uma simulação para obter os resultados das resoluções seguintes. )

`Defeito 8: substitua o "GetTickCount" por outra forma de "contar" o tempo de processamento`

Causa: Otimização!

Solução: Fiz uma rotina para trazer de forma mais clara vizualizar a tempo de performace das rotinas. 

### Threads

`Defeito 9: crie um formulário com o nome da unit “Threads.pas” e nome do form “fThreads” e altere o form Main para abrir este novo form, 
 como é feito nos outros botões. Neste form deve haver um botão que executará duas threads (aqui se entende thread, task, thread anônima, 
 qualquer tipo de programação paralela). Estas threads irão realizar um laço de 0 até 100, onde a cada iteração do laço elas deverão 
 aguardar (sleep) um tempo em milisegundos determinado pelo usuário (pode ser configurado em um TEdit). A cada iteração do laço, 
 a thread deverá incrementar uma barra de progresso, com valor Max 200 (100 de cada thread). A mesma barra de progresso deve ser usada 
 em ambas threads`

Causa: Criar Formulário com 02 Threads. 

Solução: Foi criado um formulário com uma Thread principal e 02 processamentos paralelos Task para manipular um ProgressBar.
