#Inspiration topic: https://stackoverflow.com/questions/3444645/merge-pdf-files
#This code merges all .pdf files in execution path and pages 1 and 5 of filenames containing "Gestiune"

import os
from PyPDF2 import PdfMerger
from datetime import datetime

x = [a for a in os.listdir() if a.endswith(".pdf")]
print (x)
merger = PdfMerger()
for pdf in x:
    #print (pdf.__contains__("Gestiune"))
    if (pdf.__contains__("Gestiune")):
     merger.append(open(pdf, 'rb'), pages=(0,5,4))
    else:
     merger.append(open(pdf, 'rb'))

timestring = datetime.today().strftime('%d%m%Y')
with open("MergedPDFs_" + timestring + ".pdf", "wb") as fout:
 merger.write(fout)
