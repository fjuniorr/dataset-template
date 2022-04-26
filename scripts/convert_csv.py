import sys
import pandas as pd

def convert_csv(xlsx_file_path, csv_file_path):
  # referências: https://towardsdatascience.com/how-to-export-pandas-dataframe-to-csv-2038e43d9c03
  # referências: https://colab.research.google.com/drive/1R6SHFugbCEuy5ppjDFymquj3jjbgY7Sx?authuser=1
  read_file = pd.read_excel (xlsx_file_path, )
  read_file.to_csv (csv_file_path, index = None, header=True, sep = ';', decimal = ',', encoding = 'utf-8-sig', na_rep = "")

if __name__ == '__main__':
  convert_csv(sys.argv[1], sys.argv[2])