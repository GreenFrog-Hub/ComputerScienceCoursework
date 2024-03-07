import names,random,pandas,sys, importlib
importlib.reload(sys)


seven = ["BCH","HSW","SIT"]
eight = ["SOS","STF","BMW"]
nine = ["BJK","HOW"]
ten = ["CLR","HAS","BLB"]
eleven = ["CEM","ELT"]
sixthF = ["BBE","BHB","STU","BVT","SPK","EAT"]



data = pandas.DataFrame({
     'fname': [],
     'sname' : [],
     'form' : []
})
Tnames = open("Names.txt","w")

for i in range(0,900):
    fname, sname =names.get_full_name().split()
    print(fname,sname)
    randNum = random.randint(7,13)
    
    if randNum == 7:
            randPos = random.randint(0,2)
            form = str(randNum)+str(seven[randPos])
            # try:
            #     form = str(randNum)+str(seven[randPos])
            #     seven.pop(randPos)
            # except:
            #     form = "nil"
    elif randNum == 8:
            randPos = random.randint(0,2)
            form = str(randNum)+str(eight[randPos])
            # try:
            #     form = str(randNum)+str(eight[randPos])
            #     eight.pop(randPos)
            # except:
            #     form = "nil"
    elif randNum == 9:
            randPos = random.randint(0,1)
            form = str(randNum)+str(nine[randPos])
            # try:
            #     form = str(randNum)+str(nine[randPos])
            #     nine.pop(randPos)
            # except:
            #     form = "nil"
    elif randNum == 10:
            randPos = random.randint(0,2)
            form = str(randNum)+str(ten[randPos])
            # try:
            #     form = str(randNum)+str(ten[randPos])
            #     ten.pop(randPos)
            # except:
            #     form = "nil"
    elif randNum == 11:
            randPos = random.randint(0,1)
            form = str(randNum)+str(eleven[randPos])
            # try:
            #     form = str(randNum)+str(eleven[randPos])
            #     eleven.pop(randPos)
            # except:
            #     form = "nil"

    else:
            randPos = random.randint(0,5)
            form = str(randNum)+str(sixthF[randPos])
            # try:
            #     form = str(randNum)+str(sixthF[randPos])
            #     sixthF.pop(randPos)
            # except:
            #     form = "nil"
    newdata = pandas.DataFrame({
     'fname': [str(fname.encode("CP437"))],
     'sname' : [str(sname.encode("CP437"))],
     'form' : [str(form)]
    })

    data = pandas.concat([data,newdata],ignore_index=True)

    Tnames.writelines([(fname + "\n"),(sname+"\n"),str(randNum)+"\n",(form+"\n"),str(round(random.random(),3))+"\n"])



# data.to_stata('TNames.dta') 

