###############################################################################
# convert de-assembled text code to memory image for brownie32-gcc
#                                             Written by Hirofumi IWATO 2008
#                              All Rights Reserved 2008. ASIP Solutions, Inc.
#       Modified by Sajjad to insert 4 bytes for a word: i.e
#       10010 00           is replaced to:  10010 00
#       10014 23                            10011 00 
# 					    10012 00	
#                                           10013 00
#                                           10014 23
###############################################################################
# to convert 0x- string to integer
function atox(str){
  len = length(str);
  sum = 0;

  for(i=1; i<=len; i++){
    sum = sum * 16;

    c = substr(str, i,1);

    if(c == "0") sum += 0;
    else if(c == "1") sum += 1;
    else if(c == "2") sum += 2;
    else if(c == "3") sum += 3;
    else if(c == "4") sum += 4;
    else if(c == "5") sum += 5;
    else if(c == "6") sum += 6;
    else if(c == "7") sum += 7;
    else if(c == "8") sum += 8;
    else if(c == "9") sum += 9;
    else if(c == "a") sum += 10;
    else if(c == "b") sum += 11;
    else if(c == "c") sum += 12;
    else if(c == "d") sum += 13;
    else if(c == "e") sum += 14;
    else if(c == "f") sum += 15;
    else print "fatal error occured in atox";
  }

  return sum;
}

###############################################################################
BEGIN {
  cur_addr   = 0;
  in_section = 0;
}


###############################################################################
/^Contents of section/ {
  if($4 ~ /^\..*text/ || $4 ~ /^\.comment/){
    in_section = 0;
  }
  else if($4 !~ /^\..*text/){
    in_section = 1;
  }
}


###############################################################################
/^ [[:xdigit:]]+ / {
  if(in_section){
    base_addr = atox($1);

    for(i=2; i<=NF; i++){
      #for(j=0; j<length($i)/2; j++){
      for(j=0; j<4; j++){
	if (length($i)/2 >= 4)
	{
        	printf("%08x %s\n", base_addr + (i-2)*4 + j, substr($i, 1+j*2, 2));
	}
	else
	{
          	printf("%08x %s\n", base_addr + (i-2)*4 + j, "00");
	}
        
      }

    }

    cur_addr = base_addr + (NF-1)*4;
  }
}

###############################################################################
END{
  # finish up remainder of the final data

}
