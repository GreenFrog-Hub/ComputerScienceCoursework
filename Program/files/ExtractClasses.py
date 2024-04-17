import pandas as pd
import re
def findClass(textLine):
    for i in textLine:
        matched = re.match(r'\d{1}\w', i)
        if matched:
            return i.split(",")[0]


f = open("Year9TimeTableTxt.txt","w")
clasListArray = ["9AT1/Ch", "9AT2/Ch", "9AT1/Bi", "9AT2/Bi", "9AT1/Ph", "9AT2/Ph", "9AAX/Ma", "9AAX/En", "9AAX/Lf", "9AAX/Rpe", "9AAY/Ma", "9AAY/En", "9AAY/Lf", "9AAY/Rpe", "9AP1", "9AP2", "9BT1/Ch", "9BT2/Ch", "9BT1/Bi", "9BT2/Cp", "9BT1/Ph", "9BT2/Ph", "9BAX/Ma", "9BAX/En", "9BAX/Lf", "9BAX/Rpe", "9BAY/Ma", "9BAY/En", "9BAY/Lf", "9BAY/Rpe", "9BP1", "9BP2", "9B/Fr1", "9B/Dt1", "9B/Gg1", "9B/Hi1", "9C/Dr1", "9C/Ar1", "9C/Py1", "9C/Dt1", "9D/Cp1", "9D/Bs1", "9D/Mu1", "9D/Gm1"]
dataframe1 = pd.read_excel("C:\ComputerScienceCoursework\Y7 and 12 TT as of 2024-03-21 School Timetable.xlsx","Y9",)
for x in clasListArray:
    f.write(x+"\n")
    for a in range(0,10):
        for b in range(2,7):
            cellValue = dataframe1.iloc[a,b]
            for c in range(0,4):
                classList = cellValue.split("\n")[c].split(" ")
                className = findClass(classList)
                if className == x:
                    print(className,":",x)
                    print(b-1)
                    print(a+1)
                    f.write(str(b-1)+"\n")
                    f.write(str(a+1)+"\n")
    f.write("Q\n")
                
f.close()