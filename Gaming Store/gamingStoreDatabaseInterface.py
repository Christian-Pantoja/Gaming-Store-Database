import mysql.connector
import tkinter as tk
from tkinter import *
from tkinter import messagebox
from subprocess import call
from tkinter import ttk
from tabulate import tabulate

global mycursor
mysqldb = mysql.connector.connect(host = "localhost", user="root", password= "Football12", database = "gaming_store_database")
mycursor = mysqldb.cursor()

def delEmp():

    delID = int(delEMPEntry.get())

    delSQLEMP = "DELETE FROM employees WHERE EMP_ID = %s;"
    delSQLASC = "DELETE FROM associate WHERE EMP_ID = %s;"

    mycursor.execute(delSQLEMP, [(delID)])
    mysqldb.commit()

    mycursor.execute(delSQLASC, [(delID)])
    mysqldb.commit()

    insertLabel = Label(rootManager, text="Deleted").place(x=250,y=300)

def insertEmp():

    EmpID = int(EmpIDEntry.get())
    EmpPW = str(EmpPWEntry.get())
    EmpName = str(EmpNameEntry.get())
    EmpManager = str(EmpManagerEntry.get())
    EmpSalary = int(EmpSalaryEntry.get())
    EmpStore = int(EmpStoreEntry.get())

    insertEmpSQL = "INSERT INTO employees (EMP_ID, EMP_Pass, EMP_Name, EMP_Salary, EMP_Manager, STO_ID) VALUES (%s, %s, %s, %s, %s, %s);"
    insert2 = "INSERT INTO associate (EMP_ID, NumOfSales) VALUES (%s, '0');"
    mycursor.execute(insertEmpSQL, [(EmpID), (EmpPW), (EmpName), (EmpSalary), (EmpManager), (EmpStore)])
    mysqldb.commit()
    mycursor.execute(insert2, [(EmpID)])
    mysqldb.commit()
    insertLabel = Label(rootManager, text="Inserted").place(x=250,y=400)

def search():

    product_name = prodSearch.get()
    root3 = Tk()
    root3.geometry("1000x1000")

    #create button like username so implement userNameEntry entry aspect button
    inputty = "Select PROD_Name, PROD_Quantity, STO_ID from Inventory where PROD_Name = %s"
    mycursor.execute(inputty, [(product_name)])

    e = Entry(root3, width=40, fg='Red') 
    e.grid(row=0, column=0) 
    e.insert(END, "Product Name")
    e = Entry(root3, width=40, fg='Red') 
    e.grid(row=0, column=1) 
    e.insert(END, "Product Quantity")
    e = Entry(root3, width=40, fg='Red') 
    e.grid(row=0, column=2) 
    e.insert(END, "Store Number")

    i=1
    for Inventory in mycursor: 
        for j in range(len(Inventory)):
            e = Entry(root3, width=40, fg='blue') 
            e.grid(row=i, column=j) 
            e.insert(END, Inventory[j])
        i=i+1

def search_GC():

    product_name = CompSearch.get()
    root3 = Tk()
    root3.geometry("500x500")

    inputty = "SELECT * FROM Product WHERE P_Name = %s"
    mycursor.execute(inputty, [(product_name)])
    
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=0)
    e.insert(END, "Product ID")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=1) 
    e.insert(END, "Product Name")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=2) 
    e.insert(END, "Store ID")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=3) 
    e.insert(END, "FK")

    i=1
    for Inventory in mycursor: 
        for j in range(len(Inventory)):
            e = Entry(root3, width=20, fg='blue')
            e.grid(row=i, column=j) 
            e.insert(END, Inventory[j])
        i=i+1
    
def search_GS():

    temp = StuSearch.get()
    root3 = Tk()
    root3.geometry("700x500")

    inputty = "Select * from Games where G_name = %s"
    mycursor.execute(inputty, [(temp)])

    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=0)
    e.insert(END, "Product ID")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=1) 
    e.insert(END, "Product Name")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=2) 
    e.insert(END, "Price")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=3) 
    e.insert(END, "Version")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=4) 
    e.insert(END, "Store Number")
    e = Entry(root3, width=20, fg='Red')
    e.grid(row=0, column=5) 
    e.insert(END, "FK")

    i=1
    for Inventory in mycursor: 
        for j in range(len(Inventory)):
            e = Entry(root3, width=20, fg='blue')
            e.grid(row=i, column=j) 
            e.insert(END, Inventory[j])
        i=i+1

def view_inventory():

    root4 = Tk()
    root4.geometry("1000x1000")

    wrapper1 = LabelFrame(root4,width=1000, height=1000)

    myCanvas = Canvas(wrapper1, width=950, height=950)
    myCanvas.pack(side=LEFT)

    yscroll = ttk.Scrollbar(wrapper1, orient="vertical", command=myCanvas.yview)
    yscroll.pack(side=RIGHT, fill="y")

    myCanvas.configure(yscrollcommand=yscroll.set)

    myCanvas.bind('<Configure>', lambda e: myCanvas.configure(scrollregion =myCanvas.bbox("all")))

    myFrame = Frame(myCanvas)
    myCanvas.create_window((0,0), window=myFrame, anchor="nw")

    wrapper1.pack(fill="both", expand="yes", padx=10, pady=10)

    mycursor.execute("Select PROD_Name, PROD_Quantity, STO_ID from Inventory")

    e = Entry(myFrame, width=40, fg='Red')
    e.grid(row=0, column=0)
    e.insert(END, "Product Name")
    e = Entry(myFrame, width=40, fg='Red')
    e.grid(row=0, column=1) 
    e.insert(END, "Product Quantity")
    e = Entry(myFrame, width=40, fg='Red')
    e.grid(row=0, column=2) 
    e.insert(END, "Store Number")

    i=1
    for Inventory in mycursor: 
        for j in range(len(Inventory)):
            e = Entry(myFrame, width=40, fg='blue')
            e.grid(row=i, column=j) 
            e.insert(END, Inventory[j])
        i=i+1

def view_all_tables():

    table_search = tableSearch.get()

    root4 = Tk()
    root4.geometry("1000x1000")

    wrapper1 = LabelFrame(root4,width=1000, height=1000)

    myCanvas = Canvas(wrapper1, width=950, height=950)
    myCanvas.pack(side=LEFT)

    yscroll = ttk.Scrollbar(wrapper1, orient="vertical", command=myCanvas.yview)
    yscroll.pack(side=RIGHT, fill="y")

    myCanvas.configure(yscrollcommand=yscroll.set)

    myCanvas.bind('<Configure>', lambda e: myCanvas.configure(scrollregion =myCanvas.bbox("all")))

    myFrame = Frame(myCanvas)
    myCanvas.create_window((0,0), window=myFrame, anchor="nw")

    wrapper1.pack(fill="both", expand="yes", padx=10, pady=10)

    mycursor.execute("Select * FROM " + str(table_search) + ";")

    i=1
    for x in mycursor: 
        for j in range(len(x)):
            e = Entry(myFrame, width=40, fg='blue')
            e.grid(row=i, column=j) 
            e.insert(END, x[j])
        i=i+1

def login():

    username = userNameEntry.get()
    password = passWordEntry.get()

    #converted it into a string
    #if associate box is checked then look in the customer entity
    #have to change where you select the user information from
    #should match if statement 3 but cutomers only have a serach function
    
    if associateVar.get() == 1:
        sql = "SELECT associateUserAndPass.EMP_ID, associateUserAndPass.EMP_Pass FROM (SELECT employees.EMP_ID, employees.EMP_Pass FROM associate INNER JOIN employees ON associate.EMP_ID = employees.EMP_ID) AS associateUserAndPass WHERE associateUserAndPass.EMP_ID = %s AND associateUserAndPass.EMP_Pass = %s;"
        mycursor.execute(sql, [(username), (password)])
        results = mycursor.fetchall()
        
        if results:
            
            rootAssociate = Tk()
            rootAssociate.geometry("300x300")
            Label(rootAssociate, text="ASSO").place(x=0, y=0)

            global prodSearch
            prodSearch = Entry(rootAssociate)
            prodSearch.place(x=130, y = 55)
            Button(rootAssociate, text="Product Search", command=search, height = 3, width = 13).place(x=0, y=40)
            
            global e4
            Button(rootAssociate, text="View All Inventory", command=view_inventory, height = 3, width = 13).place(x=0, y=100)

            return True

        else:
            messagebox.showinfo("", "incorrect")
            return False

    # if manager box is checked then look in the customer entity
    elif managerVar.get() == 1:
        
        sql = "SELECT managerUserAndPass.EMP_ID, managerUserAndPass.EMP_Pass FROM (SELECT employees.EMP_ID, employees.EMP_Pass FROM manager INNER JOIN employees ON manager.EMP_ID = employees.EMP_ID) AS managerUserAndPass WHERE managerUserAndPass.EMP_ID = %s AND managerUserAndPass.EMP_Pass = %s"
        mycursor.execute(sql, [(username), (password)])
        results = mycursor.fetchall()
       
        if results:

            global rootManager
            rootManager = Tk()
            rootManager.geometry("500x500")
            
            my_notebook = ttk.Notebook(rootManager)
            my_notebook.pack()
            
            tab1 = Frame(my_notebook, width = 500, height= 500)
            tab2 = Frame(my_notebook)
            tab3 = Frame(my_notebook)
            
            tab1.pack(fill="both", expand=1)
            tab2.pack(fill="both", expand=1)
            tab3.pack(fill="both", expand=1)

            my_notebook.add(tab1, text="Home")
            my_notebook.add(tab2, text="Insert")
            my_notebook.add(tab3, text="Delete")

            global tableSearch
            tableSearch = Entry(tab1)
            tableSearch.place(x=10, y = 30)
            Button(tab1, text="Table name enter", command=view_all_tables, height = 3, width = 13).place(x=140, y=10)

            sqlEmpPrint = "SELECT * FROM employees"
            mycursor.execute(sqlEmpPrint)
            res = mycursor.fetchall()
            
            labelprint = Label(tab1, text = tabulate(res), justify=LEFT).place(x=0, y = 100) 
            
            #---------------------------------------------------------------------------------------------------------------------------------
            
            global EmpIDEntry, EmpPWEntry, EmpNameEntry, EmpManagerEntry, EmpSalaryEntry, EmpStoreEntry 

            EmpIDLabel = Label(tab2, text = "Employee ID: ").grid(column = 0, row = 0, padx = 30, pady = 10)
            EmpIDEntry = Entry(tab2)
            EmpIDEntry.place(x=150, y=12)
            
            EmpPWLabel = Label(tab2, text = "Employee Password: ").grid(column = 0, row = 1, padx = 30, pady = 10)  
            EmpPWEntry = Entry(tab2)
            EmpPWEntry.place(x=150, y=52)

            EmpNameLabel = Label(tab2, text = "Employee Name: ").grid(column = 0, row = 2, padx = 30, pady = 10)  
            EmpNameEntry = Entry(tab2)
            EmpNameEntry.place(x=150, y=96)

            EmpSalaryLabel = Label(tab2, text = "Employee Salary: ").grid(column = 0, row = 3, padx = 30, pady = 10)  
            EmpSalaryEntry = Entry(tab2)
            EmpSalaryEntry.place(x=150, y=140)
            
            EmpManagerLabel = Label(tab2, text = "Employee Manager: ").grid(column = 0, row = 4, padx = 30, pady = 10)  
            EmpManagerEntry = Entry(tab2)
            EmpManagerEntry.place(x=150, y=184)

            EmpStoreLabel = Label(tab2, text = "Store ID: ").grid(column = 0, row = 5, padx = 30, pady = 10)  
            EmpStoreEntry = Entry(tab2)
            EmpStoreEntry.place(x=150, y=228)

            EmpInsertButton = Button(tab2, text="Insert", command=insertEmp).grid(column = 1, row = 6, padx = 30, pady = 10)
            
            #-----------------------------------------------------------------------------------------------------------------------
  
            global delEMPEntry

            l3 = Label(tab3, text ="Delete Associate").grid(column = 0, row = 0, padx = 30, pady = 5)

            delEMPLabel = Label(tab3, text = "Employee ID: ").grid(column = 0, row = 1, padx = 30, pady = 5)
            delEMPEntry = Entry(tab3)
            delEMPEntry.place(x=150, y=35)

            EmpDelButton = Button(tab3, text="Delete", command=delEmp).grid(column = 1, row = 2, padx = 30, pady = 10)

            return True

        else:
            messagebox.showinfo("", "incorrect")
            return False

    #if customer box is checked then look in the customer entity
    elif customerVar.get() == 1:

        sql = "SELECT CUST_ID, CUST_Pass FROM customers WHERE CUST_ID = %s AND CUST_Pass = %s"
        mycursor.execute(sql, [(username), (password)])
        results = mycursor.fetchall()

        if results:
            rootCustomer = Tk()
            rootCustomer.geometry("300x300")
            Label(rootCustomer, text="cust").place(x=0, y=0)
          
            prodSearch = Entry(rootCustomer)
            prodSearch.place(x=130, y = 55)
            Button(rootCustomer, text="Game Search", command=search, height = 3, width = 13).place(x=0, y=30)
            return True

        else:
            messagebox.showinfo("", "incorrect")
            return False

    elif companyVar.get() == 1:

        sql = "SELECT C_Name FROM gaming_company WHERE C_ID = %s AND C_Pass = %s;"
        mycursor.execute(sql, [(username), (password)])
        results = mycursor.fetchall()
    
        if results:
            rootCompany = Tk()
            rootCompany.geometry("300x300")
            Label(rootCompany, text="COMP").place(x=0, y=0)

            global CompSearch
            CompSearch = Entry(rootCompany)
            CompSearch.place(x=130, y = 55)
            Button(rootCompany, text="Enter Prod Name", command=search_GC, height = 3, width = 13).place(x=0, y=30)
            
        else:
            messagebox.showinfo("", "incorrect")
            return False
    
    elif studioVar.get() == 1:

        sql = "SELECT STU_Name FROM gaming_studio WHERE STU_ID = %s AND STU_Pass = %s;"
        mycursor.execute(sql, [(username), (password)])
        StuNameresults = mycursor.fetchall()

        if StuNameresults:
            rootStudio = Tk()
            rootStudio.geometry("300x300")
            Label(rootStudio, text="STUD").place(x=0, y=0)

            global StuSearch
            StuSearch = Entry(rootStudio)
            StuSearch.place(x=130, y = 55)
            Button(rootStudio, text="Game name enter", command=search_GS, height = 3, width = 13).place(x=0, y=30)

        else:
            messagebox.showinfo("", "incorrect")
            return False
    
    else:
        print("did not check a box")

root = Tk()
root.title("login")
root.geometry("300x300")
global userNameEntry, passWordEntry, prodSearch, EmpIDEntry

associateVar = IntVar()
managerVar = IntVar()
customerVar = IntVar()
companyVar = IntVar()
studioVar = IntVar()

Label(root, text="username").place(x=10, y=10)
Label(root, text="password").place(x=10, y=40)

userNameEntry = Entry(root)
userNameEntry.place(x=140, y = 10)

passWordEntry = Entry(root)
passWordEntry.place(x=140, y= 40)
passWordEntry.config(show="*")

Button(root, text="login", command=login, height = 3, width = 13).place(x=10, y=100)
associate= Checkbutton(root, text="associate", variable=associateVar, onvalue=1, offvalue=0).place(x=140, y=70)
manager = Checkbutton(root, text="manager", variable=managerVar, onvalue=1, offvalue=0).place(x=140, y=100)
customer =Checkbutton(root, text="customer", variable=customerVar, onvalue=1, offvalue=0).place(x=140, y=130)
company = Checkbutton(root, text="company", variable=companyVar, onvalue=1, offvalue=0).place(x=140, y=160)
studio = Checkbutton(root, text="studio", variable=studioVar, onvalue=1, offvalue=0).place(x=140, y=190)

root.mainloop()
