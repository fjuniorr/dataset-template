from stringcase import snakecase, alphanumcase
from unidecode import unidecode
import sys
import pandas as pd 

def cabecalho (csv_file_path)

csv_reader = pd.read_csv(csv_file_path, delimiter=';', encoding = 'utf-8-sig')
cabecalho = csv_reader.head(1)
for coluna in cabecalho:
	coluna = coluna.strip()
	coluna = unidecode(coluna)
	coluna = coluna.replace(" / ", " ")
	coluna = coluna.replace("/ ", " ")
	coluna = coluna.replace(" /", " ")
	coluna = coluna.replace("/"," ")
	coluna = coluna.replace(" - "," ")
	coluna = coluna.replace("-", " ")
	coluna = coluna.replace("?", "")
	coluna = coluna.replace("(", "")
	coluna = coluna.replace(")", "")
	coluna = coluna.lower()
	coluna = coluna.split(' ')
	coluna = '_'.join(coluna)
#	print(coluna)

if __name__ == '__main__':
	cabecalho(sys.argv[1])
