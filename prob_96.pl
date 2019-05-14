#!/user/bin/perl;
use strict;
use warnings;
use 5.010;
use Math::BigInt;
my $now = time;
my $file_name = 'p096_sudoku.txt';
open(my $fh,'<',$file_name) or
	die "Can't open file $!";
my $file_name_2 = 'p096_sudoku_solution.txt';
open(my $fh2,'>',$file_name_2) or
	die "Can't open file $!";	
my $file_name_3 = 'debug.txt';
open(my $fh3,'>',$file_name_3) or
	die "Can't open file $!";	
my @sudoku = ();
my ($row,$col) = (0,0);
my $sud_num = 0;
my $line ;
my @sudoku_solution = ();
my $flag_guess_matrics = 0 ;
require 'dumpvar.pl';
while($line = <$fh>){
	if($line =~ m/Grid/g){
		($row,$col) = (0,0);
		$sud_num++;
		while($row <= 8){
			$line = <$fh>;
			for(my $i = 0;$i < 9;$i++){
				$sudoku[$row][$i]=substr($line,$i,1);
			}
			$row++;
		}
	}
	if(solve_sudoku()==1){
		print $fh2 "------SOLVED----";
		print_sudoku($sud_num);
	}else{
		print $fh2 "------Need other ideas----";
		print_sudoku($sud_num);
	};
}
#dumpValue(\@sudoku_solution);
close $fh;
close $fh2;
close $fh3;
sum_first_digits();

say "Execution time ", time - $now;



sub print_sudoku{
		my $fh;
		if($_[0]){
			$fh = $fh2;
			}else{
				$fh = $fh3;
				}
		print $fh "Grid ",$_[0],"\n";
		for(my $row = 0;$row <9;$row++){
					for(my $col = 0;$col <9;$col++){
						print $fh $sudoku[$row][$col];
						}
						print $fh "\n";
					}
	return 1;
}

sub solve_sudoku{
	my $lvl;
	my$lvl1;
	init_sol();
	print $fh3 "Initial problem state\n";
	print_sudoku();
	my $guess = 0;
	my $g_cell;
	my $g_p1;
	my $g_p2;
	my @sudoku_solution_temp=();
	my @sudoku_temp=();
	my $rt;
	my $ct;
	$flag_guess_matrics=0;
	do{
			update_solution();
			print $fh3 "***********START OF THE LOOP *****************************\n";
			$lvl = p_sud_sol();
			print $fh3 $lvl;
			row_rule_update();
				print $fh3 "\nUPDATE AFTER ROW RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			col_rule_update();
				print $fh3 "\nUPDATE AFTER COL RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			blk_rule_update();
				print $fh3 "\nUPDATE AFTER BLK RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			assert_row();
				print $fh3 "\nUPDATE AFTER ROW-assert RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			assert_col();
				print $fh3 "\nUPDATE AFTER COL-assert RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			assert_blk();
				print $fh3 "\nUPDATE AFTER BLK-assert RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			pair_row_update();				
				print $fh3 "\nUPDATE AFTER PAIR_ROW_UPDATE RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			pair_col_update();				
				print $fh3 "\nUPDATE AFTER PAIR_COL_UPDATE RULE\n";
				print $fh3 "level is --",p_sud_sol();	
			blk_row_eliminate();
				print $fh3 "\nUPDATE AFTER BLK_ROW_ELIMINATE RULE\n";
				print $fh3 "level is --",p_sud_sol();
				print $fh3 "\n";
			blk_col_eliminate();
				print $fh3 "\nUPDATE AFTER BLK_col_ELIMINATE RULE\n";
				print $fh3 "level is --",p_sud_sol();
				print $fh3 "\n";	
			col_tripple_eliminate();	
				print $fh3 "\nUPDATE AFTER col_tripple_ELIMINATE RULE\n";
				print $fh3 "level is --",p_sud_sol();
				print $fh3 "\n";
			row_tripple_eliminate();	
				print $fh3 "\nUPDATE AFTER row_tripple_ELIMINATE RULE\n";
				print $fh3 "level is --",p_sud_sol();
				print $fh3 "\n";	
			blk_tripple_eliminate();	
				print $fh3 "\nUPDATE AFTER blk_tripple_ELIMINATE RULE\n";
				print $fh3 "level is --",p_sud_sol();
				print $fh3 "\n";				
	start:		update_sudoku();
		}while($lvl > p_sud_sol());
		my @guess_array = ();
		if($flag_guess_matrics == 0){
			@guess_array = get_pairs_for_guessing();
			$flag_guess_matrics = 1;
		}

		if($lvl !=0){
again:		if($guess ==0){
				#say "Guessed once";
				my $magic_num = shift @guess_array;
				#say "$magic_num";
				$guess=1;
				for(my $row=0;$row<9;$row++){
					for(my $col=0;$col<9;$col++){
						for(my $opt = 0 ; $opt <9;$opt++){	
							$sudoku_solution_temp[$row][$col][$opt] = $sudoku_solution[$row][$col][$opt];
						}
						$sudoku_temp[$row][$col] = $sudoku[$row][$col];
					}
				}					
				$g_cell=substr($magic_num,1,2);
				my $r = substr($g_cell,0,1);
				my $c = substr($g_cell,1,1);
				$g_p1 = substr($magic_num,3,1);
				$g_p2 = substr($magic_num,4,1);
				$sudoku_solution[$r][$c][$g_p1]=0;
				print $fh2 "\nGuessed once at $g_cell for ---",$g_p2+1,"\n";
				print $fh3 "\nGuessed once at $g_cell for ---",$g_p2+1,"\n";				
				$lvl = 800;
				goto start;
			}
			elsif($guess==1){
				$guess =0;
				#say "Guessed twice";
				for(my $row=0;$row<9;$row++){
					for(my $col=0;$col<9;$col++){
						for(my $opt = 0 ; $opt <9;$opt++){	
							$sudoku_solution[$row][$col][$opt] = $sudoku_solution_temp[$row][$col][$opt];
						}
							$sudoku[$row][$col] = $sudoku_temp[$row][$col];
					}
				}
				my $r = substr($g_cell,0,1);
				my $c = substr($g_cell,1,1);
				$sudoku_solution[$r][$c][$g_p2]=0;
				print $fh2 "\nGuessed second time at $g_cell for ---",$g_p1+1,"\n";			
				print $fh3 "\nGuessed second time at $g_cell for ---",$g_p1+1,"\n";	
				print $fh3 "level is --",p_sud_sol();
				print $fh3 "\n";								
				$lvl = 800;
				goto start;				
			}
		 }
		 for(my $row=0;$row<9;$row++){
			for(my $col=0;$col<9;$col++){
				if($sudoku[$row][$col]==0){
					goto again;
				}
			}
		}
	return 1 if $lvl ==0;
	return 0;
}

sub get_pairs_for_guessing{
	my @arr;
	for(my $row=0;$row<9;$row++){
		for(my $col=0;$col<9;$col++){
			my $n=0;
			my $str;
			for(my $opt = 0 ; $opt <9;$opt++){
				$n += $sudoku_solution[$row][$col][$opt];
				$str = $str.$sudoku_solution[$row][$col][$opt];
			}
			if($n==2){
				my $g_cell=$row.$col;
				my $rt = $row;
				my $ct = $col;
				my $g_p1 = index($str,1);
				my $g_p2 = index($str,1,$g_p1+1);	
				my $key = $g_cell.$g_p1.$g_p2;
				push(@arr,$key);
			}
		}
	}
	for my $i (0..scalar @arr -1){
		for my $j ($i+1..scalar @arr -1){
			if(length($arr[$i]) <5){
				if(length($arr[$j]) <5){
					my $i_r = substr($arr[$i],0,1);
					my $i_c = substr($arr[$i],1,1);
					my $i_pos = substr($arr[$i],2,2);
					my $j_r = substr($arr[$j],0,1);
					my $j_c = substr($arr[$j],1,1);
					my $j_pos = substr($arr[$j],2,2);
					if($i_r == $j_r){
						if($i_pos == $j_pos){
							$arr[$i] = '1'.$arr[$i];
							$arr[$j] = '1'.$arr[$j];
						}
					}elsif($i_c == $j_c){
						if($i_pos == $j_pos){
							$arr[$i] = '1'.$arr[$i];
							$arr[$j] = '1'.$arr[$j];
						}
					}elsif((int($i_r/3) == int($j_r)/3) && (int($i_c/3) == int($j_c)/3)){
						if($i_pos == $j_pos){
							$arr[$i] = '1'.$arr[$i];
							$arr[$j] = '1'.$arr[$j];
						}
					}
				}
			}
		}
	}
	for my $i (0..scalar @arr -1){
		if(length($arr[$i]) <5){
			$arr[$i] = '0'.$arr[$i];
		}
	}
#	say @arr;
	@arr = sort @arr;
	#say @arr;
	return @arr;
	


}

sub blk_tripple_eliminate{
	for(my $blk = 0; $blk <9 ; $blk++){
		my $rl = int($blk/3)*3; 
		my $ru = int($blk/3)*3 + 3;
		my $cl = int($blk%3)*3; 
		my $cu = int($blk%3)*3 + 3;		
		my @r_arr = ();
		my @c_arr = ();
		my @s_arr = ();
		for(my $row = $rl;$row < $ru; $row++){
			for(my $col = $cl; $col < $cu; $col++){
				my $str;
				my $n;
				for(my $opt = 0; $opt < 9; $opt++){
					$str = $str.$sudoku_solution[$row][$col][$opt];
					$n += $sudoku_solution[$row][$col][$opt];
				}
				if(($n==2)|($n==3)){
					push(@r_arr,$row);
					push(@c_arr,$col);
					push(@s_arr,$str);
				}
			}
		}
		if(scalar @r_arr > 2){
			for(my $i = 0 ;$i < scalar @r_arr;$i++){
				my $s1 = $s_arr[$i];
					for(my $j = $i+1 ;$j < scalar @r_arr;$j++){
						my $s2 = $s_arr[$j];
						my $temp = $s1 | $s2;
						my $sum=0;
						for(my $cnt = 0; $cnt < 9 ;$cnt++){
							$sum += substr($temp,$cnt,1);
						}
						if(($sum ==2) | ($sum==3)){
							for(my $k = $j+1 ;$k < scalar @r_arr;$k++){
								my $s3 = $s_arr[$k];
								my $temp1 = $temp | $s3;
								my $sum=0;
								for(my $cnt = 0; $cnt < 9 ;$cnt++){
									$sum += substr($temp1,$cnt,1);
								}
								if(($sum==2) | ($sum==3)){
									my ($c1,$r1) = ($c_arr[$i],$r_arr[$i]);
									my ($c2,$r2) = ($c_arr[$j],$r_arr[$j]);
									my ($c3,$r3) = ($c_arr[$k],$r_arr[$k]);
									my $p1 = index($temp1,1);
									my $p2 = index($temp1,1,$p1+1);
									my $p3 = index($temp1,1,$p2+1);
									print $fh3 "\n";
									print $fh3 "\$blk $blk--\$col1--$c1,\$row--$r1--\$row2--$r2--\$row3--$r3--\$col2--$c2,\$col3--$c3,\$p1--$p1,\$p2--$p2,\$p3--$p3";
									print $fh3 "\n$s1";
									print $fh3 "\n$s2";
									print $fh3 "\n$s3";									
									print $fh3 "\n";									
									blk_tripple($blk,$c1,$r1,$c2,$r2,$c3,$r3,$p1,$p2,$p3);				
								}
							}
						}
					}
				}		
		}
	}
}
sub blk_tripple{
	my ($blk,$c1,$r1,$c2,$r2,$c3,$r3,$p1,$p2,$p3)=@_;
	my $rl = int($blk/3)*3; 
	my $ru = int($blk/3)*3 + 3;
	my $cl = int($blk%3)*3; 
	my $cu = int($blk%3)*3 + 3;	
	for(my $row = $rl;$row < $ru;$row++){
		for(my $col = $cl;$col < $cu;$col++){
			if($row.$col != $r1.$c1){
				if($row.$col != $r2.$c2){			
					if($row.$col != $r3.$c3){
						$sudoku_solution[$row][$col][$p1] = 0;
						$sudoku_solution[$row][$col][$p2] = 0;					
						$sudoku_solution[$row][$col][$p3] = 0;					
					}
				}
			}
		}
	}
	return 1;
}


sub row_tripple_eliminate{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			my ($n1,$col1,$col2,$col3)=(0,0,0,0);
			for(my $opt = 0; $opt < 9 ;$opt++){
				$n1 +=$sudoku_solution[$row][$col][$opt];	
			}
			if(($n1 == 2) || ($n1 == 3)){
				my $s1;
				for(my $opt = 0; $opt < 9 ;$opt++){
					$s1 = $s1.$sudoku_solution[$row][$col][$opt];	
				}
				$s1 = '0'x(9-length($s1)).$s1;
				my $col1 = $col;
				for(my $c1 = $col+1;$c1 < 9;$c1++){
					my $s2;
					my $x=0;
					for(my $opt = 0; $opt < 9 ;$opt++){
						$s2 = $s2.$sudoku_solution[$row][$c1][$opt];	
						$x += $sudoku_solution[$row][$c1][$opt];	
					}
					if(($x == 2) | ($x == 3)){
						$s2 = '0'x(9-length($s2)).$s2;
						my $t = $s1 | $s2;
						my $tsum=0;
						for(my $i=0;$i<9;$i++){
							$tsum += substr($t,$i,1);
						}
						if(($tsum == 2) || ($tsum == 3)){
						
						my $col2 = $c1;
						
						for(my $c2 = $c1+1;$c2 < 9;$c2++){
							my $s3;
							my $y=0;
							for(my $opt = 0; $opt < 9 ;$opt++){
								$s3 = $s3.$sudoku_solution[$row][$c2][$opt];	
								$y += $sudoku_solution[$row][$c2][$opt];	
							}
							if(($y == 2) | ($y == 3)){
								$s3 = '0'x(9-length($s3)).$s3;
								my $t2 = $t | $s3;		
								my $tsum2=0;
								for(my $i=0;$i<9;$i++){
									$tsum2 += substr($t2,$i,1);
								}
								if(($tsum2==2) |($tsum2==3)){
									my $col3 = $c2;
									my $p1 = index($t2,1);
									my $p2 = index($t2,1,$p1+1);
									my $p3 = index($t2,1,$p2+1);
									print $fh3 "\n";
									print $fh3 "\$row $row--\$col1--$col1,\$col2--$col2,\$col3--$col3,\$p1--$p1,\$p2--$p2,\$p3--$p3";
									print $fh3 "\n$s1";
									print $fh3 "\n$s2";
									print $fh3 "\n$s3";									
									print $fh3 "\n";
									row_tripple($row,$col1,$col2,$col3,$p1,$p2,$p3);
									}
								}
							}
						}
					}
				}
			}
		}				
	}
}

sub row_tripple{
	my $r=$_[0];
	my $p1 = $_[4];
	my $p2 = $_[5];
	my $p3 = $_[6];
	my $c1 = $_[1];
	my $c2 = $_[2];
	my $c3 = $_[3];
	for($col=0;$col < 9;$col++){
		if($col != $c1){
			if($col != $c2){
				if($col != $c3){
					$sudoku_solution[$r][$col][$p1]=0;
					$sudoku_solution[$r][$col][$p2]=0;
					$sudoku_solution[$r][$col][$p3]=0;		
				}
			}
		}
	}
	return 1;
}

sub col_tripple_eliminate{
	for(my $col = 0; $col <9; $col++){
		for(my $row = 0;$row < 9; $row++){
			my ($n1,$row1,$row2,$row3)=(0,0,0,0);
			for(my $opt = 0; $opt < 9 ;$opt++){
				$n1 +=$sudoku_solution[$row][$col][$opt];	
			}
			if(($n1 == 2) || ($n1 == 3)){
				my $s1;
				for(my $opt = 0; $opt < 9 ;$opt++){
					$s1 = $s1.$sudoku_solution[$row][$col][$opt];	
				}
				$s1 = '0'x(9-length($s1)).$s1;
				my $row1 = $row;
				for(my $r1 = $row+1;$r1 < 9;$r1++){
					my $s2;
					my $x=0;
					for(my $opt = 0; $opt < 9 ;$opt++){
						$s2 = $s2.$sudoku_solution[$r1][$col][$opt];	
						$x += $sudoku_solution[$r1][$col][$opt];	
					}
					if(($x == 2) | ($x == 3)){
						$s2 = '0'x(9-length($s2)).$s2;
						my $t = $s1 | $s2;
						my $tsum=0;
						for(my $i=0;$i<9;$i++){
							$tsum += substr($t,$i,1);
						}
						if(($tsum == 2) || ($tsum == 3)){
						
						my $row2 = $r1;
						
						for(my $r2 = $r1+1;$r2 < 9;$r2++){
							my $s3;
							my $y=0;
							for(my $opt = 0; $opt < 9 ;$opt++){
								$s3 = $s3.$sudoku_solution[$r2][$col][$opt];	
								$y += $sudoku_solution[$r2][$col][$opt];	
							}
							if(($y == 2) | ($y == 3)){
								$s3 = '0'x(9-length($s3)).$s3;
								my $t2 = $t | $s3;		
								my $tsum2=0;
								for(my $i=0;$i<9;$i++){
									$tsum2 += substr($t2,$i,1);
								}
								if(($tsum2==2) |($tsum2==3)){
									my $row3 = $r2;
									my $p1 = index($t2,1);
									my $p2 = index($t2,1,$p1+1);
									my $p3 = index($t2,1,$p2+1);
									print $fh3 "\n";
									print $fh3 "\$col $col--\$row1--$row1,\$row2--$row2,\$row3--$row3,\$p1--$p1,\$p2--$p2,\$p3--$p3";
									print $fh3 "\n$s1";
									print $fh3 "\n$s2";
									print $fh3 "\n$s3";									
									print $fh3 "\n";
									col_tripple($col,$row1,$row2,$row3,$p1,$p2,$p3);
									}
								}
							}
						}
					}
				}
			}
		}				
	}
}

sub col_tripple{
	my $c=$_[0];
	my $p1 = $_[4];
	my $p2 = $_[5];
	my $p3 = $_[6];
	my $r1 = $_[1];
	my $r2 = $_[2];
	my $r3 = $_[3];
	for($row=0;$row < 9;$row++){
		if($row != $r1){
			if($row != $r2){
				if($row != $r3){
					$sudoku_solution[$row][$c][$p1]=0;
					$sudoku_solution[$row][$c][$p2]=0;
					$sudoku_solution[$row][$c][$p3]=0;		
				}
			}
		}
	}
	return 1;
}

sub init_sol{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			for(my $opt = 0; $opt < 9 ;$opt++){
				$sudoku_solution[$row][$col][$opt]=1;		
			}
		}
	}
	return 1;
}

sub update_solution{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			if($sudoku[$row][$col] !=0){
				for(my $opt = 0; $opt < 9 ;$opt++){
						$sudoku_solution[$row][$col][$opt]=0;		
						}
					}
				}
			}
}

sub update_sol{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			if($sudoku[$row][$col] !=0){
				for(my $opt = 0; $opt < 9 ;$opt++){
						$sudoku_solution[$row][$col][$opt]=0;		
						}
					}
				}
			}
	print $fh3 "AFTER UPDATE\n";
	p_sud_sol();
			update_sudoku();
	print_sudoku();
	row_rule_update();
		update_sudoku();
	print $fh3 "------------------AFTER ROW RLE UPDATE-----------------\n";		
	p_sud_sol();
	print_sudoku();		
	col_rule_update();	
		update_sudoku();
		print $fh3 "------------------AFTER COL RLE UPDATE-----------------\n";		
	p_sud_sol();
	print_sudoku();		
	blk_rule_update();	
		update_sudoku();
		print $fh3 "------------------AFTER BLKE UPDATE-----------------\n";		
	p_sud_sol();
	print_sudoku();		
}


sub p_sud_sol{
	my $sum = 0;
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
				for(my $opt = 0; $opt < 9 ;$opt++){
						print $fh3 $sudoku_solution[$row][$col][$opt];	
						$sum += $sudoku_solution[$row][$col][$opt];
						}
						print$fh3"--";
				}
				print $fh3 "\n";
			}
			return $sum;
}

sub row_rule_update{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			my $n = $sudoku[$row][$col];
			if($n != 0){
				my $m=$n-1;
				for(my $t = 0; $t <9; $t++){
					$sudoku_solution[$row][$t][$m]=0;		
					}
				}
			}
		}
}

sub col_rule_update{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			my $n = $sudoku[$row][$col];
			if($n != 0){
				my $m=$n-1;
				for(my $t = 0; $t <9; $t++){
					$sudoku_solution[$t][$col][$m]=0;		
					}
				}
			}
		}
}

sub blk_rule_update{
	for(my $blk = 0; $blk <9 ; $blk++){
		my $rl = int($blk/3)*3; 
		my $ru = int($blk/3)*3 + 3;
		my $cl = int($blk%3)*3; 
		my $cu = int($blk%3)*3 + 3;		
		for(my $row = $rl;$row < $ru; $row++){
			for(my $col = $cl; $col < $cu; $col++){
				my $n = $sudoku[$row][$col];
				if($n != 0){
					my $m=$n-1;
					for(my $ri = $rl;$ri < $ru; $ri++){
						for(my $cj = $cl; $cj < $cu; $cj++){
							$sudoku_solution[$ri][$cj][$m]=0;		
						}
					}
				}	
			}
		}
	}
}

sub blk_row_eliminate{
	my ($n,$m)=(0,0);
	for(my $blk = 0; $blk <9 ; $blk++){
		$n='000000000';
		$m='000000000';
		my $rl = int($blk/3)*3; 
		my $ru = int($blk/3)*3 + 3;
		my $cl = int($blk%3)*3; 
		my $cu = int($blk%3)*3 + 3;		
		for(my $row = $rl;$row < $ru; $row++){
			$n='000000000';
			for(my $col = $cl; $col < $cu; $col++){
				my $opt;
				for(my $t = 0; $t <9;$t++){
					$opt = $opt.$sudoku_solution[$row][$col][$t];
				}
				$n = $n| ('0'x(9-length($opt)).$opt);
			}
			$m = $m+$n;
		}
		$m = '0'x(9-length($m)).$m;
		my $off=0;
		while((my $pos = index($m,1,$off))>-1){
			$off = $pos+1;
			my $RRR;
			my $BLK;
			for(my $i = $rl;$i < $ru; $i++){
				for(my $j = $cl; $j < $cu; $j++){
					if($sudoku_solution[$i][$j][$pos] == 1){
						$RRR=$i;		
						$BLK=$blk;
						my $flips = ROW_ELIMINATE_DUE_BLOCK($BLK,$RRR,$pos);
				#		print $fh3 "\n&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\n";
				#		print $fh3 "\nBLK ---$BLK---ROW---$RRR---POS---$pos--Flips -- $flips\n";	
						last;
					}
				}
			}
		}	
	}
}
sub ROW_ELIMINATE_DUE_BLOCK{
	my @arr = @_;
	my $r = $arr[1];
	my $bl = $arr[0];
	my $p = $arr[2];
		my $cl = int($bl%3)*3; 
		my $cu = int($bl%3)*3 + 3;	
		my $flips = 0;
		for(my $c = 0 ; $c <9;$c++){
			if(($c >= $cl) && ($c < $cu)){
			}else{
				if($sudoku_solution[$r][$c][$p] == 1){
					$flips++;
				}
				$sudoku_solution[$r][$c][$p]=0;
			}
		}
		return $flips;
}

sub blk_col_eliminate{
	my ($n,$m)=(0,0);
	for(my $blk = 0; $blk <9 ; $blk++){
		$n='000000000';
		$m='000000000';
		my $rl = int($blk/3)*3; 
		my $ru = int($blk/3)*3 + 3;
		my $cl = int($blk%3)*3; 
		my $cu = int($blk%3)*3 + 3;		
		for(my $col = $cl; $col < $cu; $col++){
			$n='000000000';
			for(my $row = $rl;$row < $ru; $row++){
				my $opt;
				for(my $t = 0; $t <9;$t++){
					$opt = $opt.$sudoku_solution[$row][$col][$t];
				}
				$n = $n| ('0'x(9-length($opt)).$opt);
			}
			$m = $m+$n;
		}
		$m = '0'x(9-length($m)).$m;
		my $off=0;
		while((my $pos = index($m,1,$off))>-1){
			$off = $pos+1;
			my $CCC;
			my $BLK;
			for(my $j = $cl; $j < $cu; $j++){
				for(my $i = $rl;$i < $ru; $i++){
					if($sudoku_solution[$i][$j][$pos] == 1){
						$CCC=$j;		
						$BLK=$blk;
						my $flips = COL_ELIMINATE_DUE_BLOCK($BLK,$CCC,$pos);
					#	print $fh3 "\n&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&\n";
					#	print $fh3 "\nBLK ---$BLK---COL---$CCC---POS---$pos--Flips -- $flips\n";		
						last;
					}
				}
			}
		}	
	}
}
sub COL_ELIMINATE_DUE_BLOCK{
	my @arr = @_;
	my $c = $arr[1];
	my $bl = $arr[0];
	my $p = $arr[2];
	my $flips = 0;
		my $rl = int($bl/3)*3; 
		my $ru = int($bl/3)*3 + 3;	
		for(my $r = 0 ; $r <9;$r++){
			if(($r >= $rl) && ($r < $ru)){
			}else{
				if($sudoku_solution[$r][$c][$p] == 1){
					$flips++;
				}
				$sudoku_solution[$r][$c][$p]=0;
			}
		}
		return $flips;
}
sub assert_blk{
	my $n=0;
	for(my $blk = 0; $blk <9 ; $blk++){
		$n=0;
		my $rl = int($blk/3)*3; 
		my $ru = int($blk/3)*3 + 3;
		my $cl = int($blk%3)*3; 
		my $cu = int($blk%3)*3 + 3;		
		for(my $row = $rl;$row < $ru; $row++){
			for(my $col = $cl; $col < $cu; $col++){
				my $opt;
				for(my $t = 0; $t <9;$t++){
					$opt = $opt.$sudoku_solution[$row][$col][$t];
				}
				$n += $opt;
			}
		}
		my $l = 9-length($n);
		$n = '0'x$l.$n;
		my $pos = index($n,1);
		if( $pos > -1){
			for(my $row = $rl;$row < $ru; $row++){
				for(my $col = $cl; $col < $cu; $col++){
					if($sudoku_solution[$row][$col][$pos] == 1){	
					#	print $fh3 "Number is $n\n";
					#	print $fh3 "Row--$row -- Col--$col -- Pos--$pos--Blk--$blk\n";	
						for(my $x = 0 ; $x < 9;$x++){
							if( $pos != $x){
								$sudoku_solution[$row][$col][$x] =0;
							}
						}
					}
				}
			}
		}
	}
}

sub assert_row{
	my $n=0;
	for($row=0;$row<9;$row++){
		$n=0;
		for($col=0;$col<9;$col++){
			my $opt;
			for(my $t = 0; $t <9;$t++){
				$opt = $opt.$sudoku_solution[$row][$col][$t];
			}
			$n += $opt;
		}
		my $l = 9-length($n);
		$n = '0'x$l.$n;
		#say "\$n issssssssssssssssssssssssssssssssss",$n;
		my $pos = index($n,1);
		if( $pos > -1){
			for(my $colX = 0 ; $colX <9; $colX++){
				if($sudoku_solution[$row][$colX][$pos] == 1){
				#	print $fh3 "Number is $n\n";
				#	print $fh3 "Row--$row -- Col--$colX -- Pos--$pos\n";				
					for(my $x = 0 ; $x < 9;$x++){
						if( $pos != $x){
							$sudoku_solution[$row][$colX][$x] =0;
						}
					}
					last;
				}
			}
		}
	}
}

sub assert_col{
	my $n=0;
	for($col=0;$col<9;$col++){
		$n=0;
		for($row=0;$row<9;$row++){
			my $opt;
			for(my $t = 0; $t <9;$t++){
				$opt = $opt.$sudoku_solution[$row][$col][$t];
			}
			$n += $opt;
		}
		my $l = 9-length($n);
		$n = '0'x$l.$n;
		my $pos = index($n,1);
		if( $pos > -1){
			for(my $rowX = 0 ; $rowX <9; $rowX++){
				if($sudoku_solution[$rowX][$col][$pos] == 1){
				#	print $fh3 "Number is $n\n";
				#	print $fh3 "Row--$rowX-- Col--$col -- Pos--$pos \n";				
					for(my $x = 0 ; $x < 9;$x++){
						if( $pos != $x){
							$sudoku_solution[$rowX][$col][$x] =0;
						}
					}
					last;
				}
			}
		}
	}
}

sub pair_row_update{
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
			my $s1;
			my $n;
			for(my $opt = 0; $opt < 9 ;$opt++){
				$n += $sudoku_solution[$row][$col][$opt];	
				$s1 = $s1.$sudoku_solution[$row][$col][$opt];	
				}
			if($n ==2){					
				for(my $c = $col+1; $c <9; $c++){
					my $m;
					my $s2;
					for(my $o = 0; $o < 9 ;$o++){
						$m += $sudoku_solution[$row][$c][$o];	
						$s2 = $s2.$sudoku_solution[$row][$c][$o];	
					}
					if($s1==$s2){
						$s1 = '0'x(9-length($s1)).$s1;
						my $pos1 = index($s1,1);
						my $pos2 = index($s1,1,$pos1+1);
						up_row_due_pair($row,$pos1,$pos2,$col,$c);
					}
				}
			}
		}
	}
}

sub up_row_due_pair{
	my $r = $_[0];
	my $p1= $_[1];
	my $p2 =  $_[2];
	my $c1 = $_[3];
	my $c2 = $_[4];	
	for(my $col = 0;$col < 9 ; $col++){
		if($col != $c1){
			if($col != $c2){
				$sudoku_solution[$r][$col][$p1] = 0;
				$sudoku_solution[$r][$col][$p2] = 0;
			}
		}
	}
}

sub pair_col_update{
	for(my $col = 0; $col <9; $col++){
		for(my $row = 0;$row < 9; $row++){
			my $s1;
			my $n;
			for(my $opt = 0; $opt < 9 ;$opt++){
				$n += $sudoku_solution[$row][$col][$opt];	
				$s1 = $s1.$sudoku_solution[$row][$col][$opt];	
				}
			if($n ==2){					
				for(my $r = $row+1; $r <9; $r++){
					my $m;
					my $s2;
					for(my $o = 0; $o < 9 ;$o++){
						$m += $sudoku_solution[$r][$col][$o];	
						$s2 = $s2.$sudoku_solution[$r][$col][$o];	
					}
					if($s1==$s2){
						$s1 = '0'x(9-length($s1)).$s1;
						my $pos1 = index($s1,1);
						my $pos2 = index($s1,1,$pos1+1);
						up_col_due_pair($col,$pos1,$pos2,$row,$r);
					}
				}
			}
		}
	}
}

sub up_col_due_pair{
	my $c = $_[0];
	my $p1= $_[1];
	my $p2 =  $_[2];
	my $r1 = $_[3];
	my $r2 = $_[4];	
	for(my $row = 0;$row < 9 ; $row++){
		if($row != $r1){
			if($row != $r2){
				$sudoku_solution[$row][$c][$p1] = 0;
				$sudoku_solution[$row][$c][$p2] = 0;
			}
		}
	}
}

sub pair_col_update_OLD{
	my $sum = 0;
	my $x;
	my %arr;
	my @t = ();
	for(my $col = 0; $col <9; $col++){
		for(my $row = 0;$row < 9; $row++){
				for(my $opt = 0; $opt < 9 ;$opt++){
						my $n = $sudoku_solution[$row][$col][$opt];
						$sum += $n;
						push(@t,$opt) if $n ==1;				
						}
					if($sum == 2){
						@{arr{$row,$col}} = @t;
						@t = ();
					#	say "\$row,",$row+1,"\$col",$col+1," ---",join('|',@{arr{$row,$col}});
					}
										$sum = 0;					
				}
				for(my $i = 0 ; $i <9;$i++){
					for(my $j = $i+1 ; $j <9;$j++){
						if(exists ${arr{$col,$i}}){
							if(exists ${arr{$col,$j}}){
						my $s1 = join('',@{arr{$col,$i}});
						my $s2 = join('',@{arr{$col,$j}});
						#say "\$s1 is ------------------",$s1;
						#say "\$s2 is ------------------",$s2;						
						if($s1 == $s2){
							my @t = @{arr{$col,$j}};
							my $n1 = $t[0];
							my $n2 = $t[1];
							#say "\$n1 is ------------------",$n1;
							#say "\$n2 is ------------------",$n2;
								for(my $c=0;$c<9;$c++){
									if($c != $i){
										if($c != $j){
											$sudoku_solution[$c][$col][$n1] = 0;
											$sudoku_solution[$c][$col][$n2] = 0;
											}
										}
									}
							}
						}}}
					}
		}
		return 1;
}
sub update_sudoku{
	my $sum = 0;
	my $x;
	for(my $row = 0;$row < 9; $row++){
		for(my $col = 0; $col <9; $col++){
				for(my $opt = 0; $opt < 9 ;$opt++){
						my $n = $sudoku_solution[$row][$col][$opt];
						$sum += $n;
						$x = $opt if $n ==1;				
						}
					if($sum == 1){
						$sudoku[$row][$col] = $x +1;
						$sudoku_solution[$row][$col][$x] = 0;
					}
				$sum = 0;
				}
			}
			return 1;
}

sub sum_first_digits{
	my $sum=0;
#	say $file_name_2;
	open my $f,'<', $file_name_2 or
		die "Can't open the file to read";
	while(my $line = <$f>){
		if($line =~ m/SOLVED/g){
			$line = <$f>;
#			say $line;
				$sum += substr($line,0,3);
		}
	}
	say "Solution to prob 96 is --- $sum ----";
}