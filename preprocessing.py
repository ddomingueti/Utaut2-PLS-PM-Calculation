'''
Author: Daniel Bueno Domingueti
Date: 18/08/2021
'''

import pandas as pd
from sklearn.preprocessing import normalize
from sklearn.preprocessing import StandardScaler
import numpy as np

# Class to ease the data manipulation and processing
# row = string; 
# values = dictionary {'field_scale_name':value_to_be_used_instead}
class DataMapping(object):
    def __init__(self, row_name, values):
        self.row=row_name
        self.values = values

# Input/Output configurations. Edit these for your needs
# Create the data mappings for each question to transform your qualitative measurements to numeric values (E.g., low,medium,high => 0,1,2)
# Edit the files' names bellow according to your original dataset and desired names
data_maps = []
data_maps.append(DataMapping("renda familiar", {'Até 2 salários mínimos':1, 'Mais de 2 s.m. até 4 s.m.':2, 'Mais de 4 s.m. até 10 s.m.':3}))
data_maps.append(DataMapping("estado civil", {'Solteiro(a)':1, 'União estável':2, 'Casado(a)':3}))
data_maps.append(DataMapping("gênero", {'Feminino':0, 'Masculino':1}))
data_maps.append(DataMapping("experiência", {'Não':0, 'Sim':1}))

original_name = "original_dataset.csv" #The original dataset, no changes
processed_name = "processed_dataset.csv" #Processed dataset, result from the "preprocessing" procedure
normalized_name = "normalized_dataset.csv" #Normalized dataset, result from the "normalization" procedure
scaled_name = "scaled_dataset.csv" #Scaled dataset, result from the "standardize" procedure

# Methods for the preprocessing, normalization and standarization of the dataset
# Read the original_name.csv, does the data mapping defined and save the result in the processed_name.csv file
def preprocessing(): 
    data = pd.read_csv(original_name, encoding='utf-8', sep=',')
    for m in data_maps:
        data[m.row] = data[m.row].replace(m.values)
    
    data.to_csv(processed_name)

# Read the processed_name.csv, does the normalization process and save the result in the normalized_name.csv file
def normalization():
    data = pd.read_csv(processed_name)
    norm = normalize(data, norm='l2').tolist()
    new_df = pd.DataFrame(norm)
    new_df.columns = data.columns
    del new_df['id']
    new_df.to_csv(normalized_name)


# Read the processed.csv, does the standardization process and save the result in the scaled_name.csv file
# Parameter: https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html?highlight=stand%20scaler
def standardize(calculate_with_mean = False):
    data = pd.read_csv(processed_name)
    scaler = StandardScaler(with_mean = calculate_with_mean)
    scaler.fit(data)
    scl = scaler.transform(data).tolist()
    new_df = pd.DataFrame(scl)
    new_df.columns = data.columns
    del new_df['id']
    new_df.to_csv(scaled_name)

# Methods execution. Comment what is not needed.
preprocessing()
normalization()
standardize()