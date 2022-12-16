import os
import sys
from frictionless import Package

def compare_data_resource_paths():
  data_resources_names = os.listdir('data')
  data_resources_paths = [os.path.join('data', i) for i in data_resources_names]
  data_resources_paths.remove('data/.gitkeep')
  data_resources_paths = set(data_resources_paths)
  local_package = Package('datapackage.json')
  datapackage_resouces_paths = [i["path"] for i in local_package.resources]
  datapackage_resouces_paths = set(datapackage_resouces_paths)
  if data_resources_paths != datapackage_resouces_paths:
    diff_datapackage_data = datapackage_resouces_paths.difference(data_resources_paths)
    if diff_datapackage_data:
      print(f'Recurso(s) no datapackage.json sem arquivo de dados correspondente em data/: {diff_datapackage_data}')
    
    diff_data_datapackage = data_resources_paths.difference(datapackage_resouces_paths)
    if diff_data_datapackage:
      print(f'Recurso(s) com arquivo de dados em data/ sem correspondente no datapackage.json: {diff_data_datapackage}')
    sys.exit(1)

if __name__ == '__main__':
  compare_data_resource_paths()