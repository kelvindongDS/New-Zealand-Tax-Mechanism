SELECT C.FName,
	   C.LName,
	   C.Register,
	   C.Active,
	   C.Geography,
	   C.TimeRegister,
	   I.CustomerID,
	   I.TaxCode,
	   I.Occupation,
	   I.Gender
INTO JOINTABLE1
FROM Customer C 
LEFT JOIN Individual I ON I.CustomerID= C.CustomerID

