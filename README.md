# Projeto Nara Hotéis - Tratamento e Análise de Dados

Este repositório contém o **Projeto de Análise de Dados**, desenvolvido com foco no processo completo de identificação, limpeza, tratamento e análise exploratória de bases de dados da rede "Nara Hotéis".

## Equipe
* Alex Justino
* Arthur Martins
* Bruno Uchoa
* Maria Chan
* Professor/Supervisor: Cassio Pereira
---

## Visão Geral do Projeto

O objetivo deste projeto é simular o cenário real de um profissional de dados ao receber arquivos brutos com diversas inconsistências. O trabalho foi dividido em duas grandes etapas:
1. **Tratamento de Dados:** Aplicação de uma metodologia rigorosa dividida em *Inspeção* (identificar problemas), *Decisão* (discutir ações) e *Correção* (aplicar os tratamentos).
2. **Análise de dados:** Geração de estatísticas, identificação de *outliers* e criação de painéis visuais para extrair inteligência de negócios e apoiar a tomada de decisão. 
3.  **Business Intelligence (Power BI):** Materialização da análise em um painel interativo para monitoramento de KPIs e performance de negócio.

---

## Estrutura e Tratamento das Bases

Foram manipuladas e consolidadas diversas bases de dados (`hoteis.csv`, `quartos.csv`, `hospedes.csv`, `reservas.csv` e `avaliacoes.csv`), incluindo dados adicionais do ano de 2025. 

Principais correções aplicadas durante o processo:

* **Hotéis:** Correção de categorias fora do domínio (ex: 6 estrelas corrigido para 5), preenchimento de valores nulos via cruzamento de dados e padronização de nomenclatura de cidades.
* **Quartos:** Padronização textual dos tipos de quartos, tratamento de capacidades inválidas (substituição pela mediana), remoção de capacidades negativas e preenchimento de valores base nulos.
* **Hóspedes:** Validação de e-mails via *Expressões Regulares (RegEx)*, padronização e filtro de telefones brasileiros (10 ou 11 dígitos), mapeamento de siglas de Estados (UF) e remoção de IDs duplicados.
* **Reservas:** Exclusão de datas incoerentes (checkout anterior ao check-in), remoção de diárias com valores negativos ou zerados, e padronização dos canais de reserva e status.
* **Avaliações:** Conversão de tipos de dados, limpeza de notas fora do escopo (0 a 10), preenchimento de dados faltantes com a mediana e cruzamento com a base de reservas para remover avaliações de hóspedes "No-show" ou com estadias canceladas.

---

## Análise Estatística

Com os dados limpos, foram aplicadas análises para entender o comportamento das vendas, sazonalidade e a satisfação dos clientes.

### Destaques Estatísticos
* Utilização do **Intervalo Interquartil (IQR)** para identificar cobranças fora do padrão (*outliers* positivos) em reservas de plataformas específicas.
* Comparação entre a Média e a Mediana para definir o valor típico pago pelas diárias.

### Painel Executivo Visual
Foram gerados gráficos de linhas e barras para monitorar:
1. **Volume de Reservas por Unidade:** Análise temporal demonstrando picos em feriados e quedas sazonais em unidades específicas como Fortaleza, Recife, RJ, SP e Salvador.
2. **Faixa de Preço e Ticket Médio:** Avaliação do preço por tipo de quarto e o desempenho financeiro de cada canal de venda (Site próprio, Booking, Expedia, etc.).
3. **Gargalos Operacionais:** Mapeamento das taxas de *Overbooking* por mês e por hotel, identificando as unidades que necessitam de intervenção urgente na alocação de capacidade.
4. **Análise de Correlação:** Estudo para verificar o impacto do atendimento na nota geral do hotel, revelando que um bom atendimento, de forma isolada, não garante a satisfação total do hóspede.


### Dashboard Executivo (Power BI)
Com a base devidamente limpa pelo processo em Python, o arquivo `Projeto_Nara_Arthur.pbix` consolida a inteligência do negócio em um ambiente interativo.
**Principais funcionalidades do Dashboard:**
* **Visão Geral de Performance:** Monitoramento dinâmico de reservas confirmadas vs. canceladas.
* **Análise de Capacidade:** Identificação visual de unidades com gargalos de *Overbooking*.
* **Filtros Inteligentes:** Segmentação por Unidade (RJ, SP, Recife, etc.), período temporal e canais de reserva (Booking, Site, Expedia).
* **Monitoramento de Satisfação:** Painel de avaliações integrado para acompanhamento da percepção do cliente em tempo real.

---

## Resumo Executivo e Insights

* **Sazonalidade:** O volume de reservas confirmadas apresenta grandes variações sazonais. Há uma necessidade de planejamento focado para suportar as altas temporadas, especialmente para mitigar a queda histórica observada após certos períodos do ano.
* **Estratégia de Preços:** A precificação possui uma boa distinção por categoria de quarto. Além disso, determinados canais de reserva atraem hóspedes com maior disposição a pagar, elevando o ticket médio.
* **Experiência do Cliente:** Não há forte correlação entre a nota de atendimento e a nota geral. Isso indica que a infraestrutura e outros serviços pesam tanto quanto a cordialidade da equipe.
* **Overbooking:** Unidades específicas lideram as taxas de overbooking, indicando a necessidade de revisar com urgência os sistemas e fluxos de reservas integradas.

---

## Tecnologias Utilizadas

* **Linguagem:** Python
* **Ambiente:** Jupyter Notebook
* **Bibliotecas Principais:** * `pandas` (Manipulação e Análise de Dados)
  * `numpy` (Operações Matemáticas)
  * `matplotlib` & `seaborn` (Visualização de Dados)
  * `re` (Expressões Regulares)
* **Business Intelligence:** Power BI Desktop (`.pbix`)

