# Example syntax for the terminal PCL type
no_logfile = true;
begin;

begin_pcl;
#print( int i )
int int_value = 1;
term.print( int_value );  

term.print("\n"); #newline via print( string s)

#print( double d )
double double_value = 1.2345;
term.print( double_value );

term.print("\n");

#print( bool b )
bool bool_value = true;
term.print( bool_value );

term.print("\n");

#print( string s )
string string_value = "string";
term.print( string_value );

term.print("\n");

#string concatenation
term.print( string_value + " " + string(bool_value) + " " + string(double_value) + " " + string(int_value));
