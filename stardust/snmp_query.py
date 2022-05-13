# Code for reading Data from Stardust API, then saving as a csv and storing in a database as a time series data
# Replace this "https://netpred-8a3a5-default-rtdb.firebaseio.com" on line 85, with your link generated form your firebase account.
# comment out the last two lines if only onluy want to save and csv you don't want to store in firebase database

import datetime
import pandas as pd
from elasticsearch import Elasticsearch
from firebase import firebase

print('1/3\tFetching data from server...')
es = Elasticsearch(["https://el.gc1.prod.stardust.es.net:9200"], timeout=60)
res = es.search(body={

    "size":0,
    "query":{
        "bool":{
            "filter":[
                {
                "range":{
                    "start":{
                        "gte":1648753659123,
                        "lte":1649358459124,
                        "format":"epoch_millis"
                    }
                }
            }
        ]
    }
 },

 "aggs":{
      "3":{
      "terms":{
         "field":"meta.device_info.loc_name",
         "size":500,
         "order":{"_key":"asc"
         },
         "min_doc_count":1
         },
 "aggs":{
      "4":{
      "terms":{
      "field":"meta.remote.loc_name",
      "size":500,
      "order":{"_key":"asc"},
      "min_doc_count":1
      },

"aggs":{
      "2":{
      "date_histogram":{
      "field":"start",
      "min_doc_count":0,
      "extended_bounds":{
                    "min":1648753659123,"max":1649358459124
                    },
                    "format":"epoch_millis",
                    "fixed_interval":"1h"
                    },
                "aggs":{
                      "1":{
                      "sum":{
                      "field":"values.in_bits.delta","script":"_value / 8"
                      }
                    },
                     "5":{
                     "sum":{
                     "field":"values.out_bits.delta","script":"_value / 8"
                                 }
                              }
                          }
                      }
                  }
              }
          }
      }
   }
}, index="sd_public_interfaces")

#Converting response to Json
json_obj = dict(res)

#Creating empty Variable data, which will contain all the useful data for converting it into Pandas Dataframe
data = dict()
is_time = True #It will avoid to create multiple Time Columns for each site.

firebase = firebase.FirebaseApplication('https://netpred-8a3a5-default-rtdb.firebaseio.com/', None)

print('2/3\tFetching useful data from raw data...')
#It's a black-box, out of your understanding
for i in json_obj['aggregations']['3']['buckets']:
    main_key = i['key']
    for j in i['4']['buckets']:
        sub_key = j['key']
        for k in j['2']['buckets']:
            row = k
            key = row['key']
            date_time = datetime.datetime.fromtimestamp(key/1000).strftime('%Y-%m-%d %H:%M:%S')
            in_value = row['1']['value']
            out_value = row['5']['value']
            if main_key+'_'+sub_key+'_in' in data.keys():
                data[main_key+'_'+sub_key+'_in'].append(in_value)
            else:
                data[main_key + '_' + sub_key + '_in'] = [in_value]

            if main_key + '_' + sub_key + '_out' in data.keys():
                data[main_key + '_' + sub_key + '_out'].append(out_value)
            else:
                data[main_key + '_' + sub_key + '_out'] = [out_value]

            if is_time:
                if 'Time' in data.keys():
                    data['Time'].append(date_time)
                else:
                    data['Time'] = [date_time]
        is_time = False

#Converting data into Dataframe
print('3(a)/3\tConverting into CSV & Saving the file.')
df = pd.DataFrame(data)
df.set_index('Time', inplace=True) # Setting Time Column as index
df.to_csv('File.csv') # Generating CSV file.


print('3(b)/4Pushing to Firebase Realtime DB...')
result = firebase.post('/extracted_data/',data) # pushing to Firebase Realtime Database
