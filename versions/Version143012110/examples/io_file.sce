# demonstrates reading and writing from text files
# using the input_file and output_file types    

# !! default_logfile_directory must be the same directory
# as this pcl file for this scenario to work!!
no_logfile = true;
begin;

begin_pcl;
#--------------------------------------------------------------
# write data using output_file type
     
# some fake data to read and write

array<int> int_data[5] = { 1, 2, 3, 4, 5 };
array<double> float_data[5] = { 1.1, 2.2, 3.3, 4.4, 5.5 };
array<bool> bool_data[5] = { true, false, true, false, true };
array<string> string_data[5] = { "text 1", "text 2", "text 3", 
                                 "text 4", "text 5" };
                                 
output_file out = new output_file;
out.open( "io_example.txt" ); 
out.print( "strings\tints\tdoubles\tbools\n" );  
loop
   int i = 1
until
   i > 5
begin
   out.print( string_data[i] );
   out.print( "\t" );
   out.print( int_data[i] );
   out.print( "\t" );
   out.print( float_data[i] );
   out.print( "\t" );
   out.print( bool_data[i] ); 
   if i != 5 then
      out.print( "\n" );  
   end;     
   i = i + 1
end;
out.close();
                                                       
#--------------------------------------------------------------
# read data using input_file type  

# places to put the data
# doesn't assume table size - 100 line maximum         
array<int> int_data2[100];
array<double> float_data2[100];
array<bool> bool_data2[100];
array<string> string_data2[100]; 
array<string> column_names[4]; 
 
input_file in = new input_file;
in.open( "io_example.txt" );
in.set_delimiter( '\t' ); # for get_line()
column_names[1] = in.get_string();
column_names[2] = in.get_string();
column_names[3] = in.get_string();
column_names[4] = in.get_string();  
int count = 0;
loop until
   in.end_of_file() || count == 100 || !in.last_succeeded()
begin
   count = count + 1;
   string_data2[count] = in.get_line();
   int_data2[count] = in.get_int();
   float_data2[count] = in.get_double();
   bool_data2[count] = in.get_string() == "true";
end;  

if !in.last_succeeded() then
   term.print( "Error while reading!\n" )
elseif !in.end_of_file() then
   term.print( "Exceeded capacity!\n" )
end;   
   
#--------------------------------------------------------------
# print to terminal to see if we got it right
term.print( column_names[1] + "\t" + column_names[2] + "\t" +
            column_names[3] + "\t" + column_names[4] + "\n" );
loop
   int i = 1
until
   i > count
begin
   term.print( string_data2[i] );
   term.print( "\t" );
   term.print( int_data2[i] );
   term.print( "\t" );
   term.print( float_data2[i] );
   term.print( "\t" );
   term.print( bool_data2[i] );
   term.print( "\n" );
   i = i + 1
end

