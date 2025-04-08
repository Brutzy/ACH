package main

import (
	`encoding/csv`
	`fmt`
	`io`
	`log`
	`net/smtp`
	`os`
)

// ______________________________________________________________
func ff(text string, length int) string {
	return fmt.Sprintf("%-*s", length, text)
}

// ____________________________________________________
func message_handler(recipient string, msg_str string ) {

	auth := smtp.PlainAuth("", "billb@hkmetalcraft.com", "xxxx xxxx yyyy zzz", "smtp.gmail.com")

	to := []string{``}

	msg := []byte("To: "                             + recipient + "\r\n" +
		          "Subject: HK ACH Remittance \r\n"  + msg_str )
																							   to[0] = recipient
				  err_x := smtp.SendMail("smtp.gmail.com:587", auth, "billb@hkmetalcraft.com", to, msg);
	 
	 if err_x != nil { log.Fatal(err_x) }
}

// ______________________________________________________________
func main() {

	prior_f0 := ``
	prior_f1 := `` // Supplier
	prior_f2 := ``
	prior_f3 := ``

	this_f0 := ``
	this_f1 := ``
	this_f2 := ``
	this_f3 := ``
	this_f4 := ``
	this_f5 := ``
	this_f6 := ``

    this_Supplier  := this_f1 
	prior_Supplier := prior_f1

	x0 := `` // ACH date
	x1 := `` // Supplier
	x2 := `` // Check #
	x3 := `` // Check Amount
	x4 := `` // Item Amount
	x5 := `` // Invoice Date
	x6 := `` // Invoice #

	x0_L := 12
	x1_L := 20 
	x2_L := 10 
	x3_L := 10 
	x4_L := 10 
	x5_L := 12 
	x6_L := 10 

	x0_F := ""
	x1_F := ""
	x2_F := ""
	x3_F := ""
	x4_F := ""
	x5_F := ""
	x6_F := ""

	check_header     := "ACH-Date____Payee_______________Check #___Amount_____ \n"
    line_item_header := "item $____Inv_Date____Invoice #__ \n"

    recipient := ``
    msg_str   := ``

	 //____________________________________________________________________________________
	 
	                             this_file := `remit.csv`
	 file_data, err_r := os.Open(this_file)

	 if err_r != nil {
		 fmt.Println(`Error reading remit.csv file:`, err_r)
		 return
	 }
 
    rr := csv.NewReader(file_data)

    check_line_item := -1

	for {

		check_line_item += 1

		record, err_c := rr.Read()

	    	 if err_c == io.EOF {  message_handler(recipient, msg_str)
			                       break
					            }

		     if err_c != nil { log.Fatal(err_c) }

		this_f0 = record[0] 
		this_f1 = record[1]   // Supplier
		this_f2 = record[2] 

		this_Supplier = this_f1 

		this_f3 = record[3] 
		this_f4 = record[4] 
		this_f5 = record[5] 
		this_f6 = record[6] 

		recipient = record[7] 
		recipient = `brutzy@gmail.com`
		
        if (this_f0 == prior_f0) { x0 = `` 
		} else                   { x0 = this_f0 }

        if (this_f1 == prior_f1) { x1 = `` 
		} else                   { x1 = this_f1 }

        if (this_f2 == prior_f2) { x2 = `` 
	    } else                   { x2 = this_f2 }

        if (this_f3 == prior_f3) { x3 = `` 
	    } else                   { x3 = this_f3 }

								   x4 = this_f4 
								   x5 = this_f5 
								   x6 = this_f6 

								   x0_F = ff(x0, x0_L)
								   x1_F = ff(x1, x1_L)
								   x2_F = ff(x2, x2_L)
								   x3_F = ff(x3, x3_L)
								   x4_F = ff(x4, x4_L)
								   x5_F = ff(x5, x5_L)
								   x6_F = ff(x6, x6_L)

  	switch check_line_item {
								case 0:  msg_str += check_header
								case 1: msg_str +=  x0_F +  x1_F + x2_F + x3_F       + "\n \n" 

										msg_str += line_item_header
										msg_str +=  x4_F    + x5_F    + x6_F         + "\r\n " 

								default: msg_str +=  x4_F + x5_F + x6_F + "\r\n " 
								}

	if ( (prior_Supplier != ``) && ( this_Supplier != prior_Supplier)) {
																		 message_handler(recipient, msg_str)
																	   }
							
							
		prior_f0 = this_f0
		prior_f1 = this_f1
		prior_f2 = this_f2
		prior_f3 = this_f3

		prior_Supplier = prior_f1 

	}

	println() 
	fmt.Printf( msg_str )
	println() 

}
