## Author: Jiminy Cricket
## Version: 1.0
## Purpose: Play Hangman

use 5.16.3;
use warnings;
use strict;

my (@letters,@correctLetters,@guessedLetters);
my ($continue,$solve,$word,$guess,$wrongGuess,$maxWrongGuesses);

use constant YES => 1;

sub main {
	setContinue();
	while ($continue == YES) {
		setDifficulty();
		giveWord();
		populateArrays();
		resetVariables();
		while ($solve != YES && $wrongGuess < $maxWrongGuesses) {
			setGuess();
			addGuess();
			checkGuess();
			checkSolve();
		}
		results();
		setContinue();
	}
}

main();

sub setContinue {
	if (defined $continue) {
	$continue = -1;
	while ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
			say "Would you like to continue?";
			say "Enter 1 for yes and 0 for no.";
			chomp ($continue = <STDIN>);
			if ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
				print "\nINVALID INPUT";
				sleep 2;
				system ("cls");
			}
		}
	} else {
		$continue = 1;
	}
}

sub setDifficulty {
	my $difficulty = 0;
	while ($difficulty !~ /[0-9]/ || $difficulty > 5 || $difficulty < 1) {
		say "What difficulty level would you like to play at?";
		say "Difficulty is between 1 and 5, with 1 being easiest and 5 being hardest.";
		say "Standard difficulty is 3.";
		chomp ($difficulty = <STDIN>);
		if ($difficulty !~ /[0-9]/ || $difficulty > 5 || $difficulty < 1) {
			say "\nINCORRECT INPUT";
			sleep 2;
			system ("cls");
		}
	}
	readDifficulty($difficulty);
}

sub readDifficulty {
	my $difficulty = $_[0];
	if ($difficulty == 1) {
		$maxWrongGuesses = 12;
	} elsif ($difficulty == 2) {
		$maxWrongGuesses = 9;
	} elsif ($difficulty == 3) {
		$maxWrongGuesses = 6;
	} elsif ($difficulty == 4) {
		$maxWrongGuesses = 3;
	} else {
		$maxWrongGuesses = 1;
	}
}

sub giveWord {
	$word = 0;
	while ($word !~ /[a-z]{5,20}/) {
		say "Please give a word with at least 5 letters, all lowercase.";
		chomp ($word = <STDIN>);
		if ($word !~ /[a-z]{5,20}/) {
			say "\nINVALID INPUT";
			sleep 2;
			system ("cls");
		}
	}
	system ("cls");
}

sub populateArrays {
	@letters = split('',$word);
	my $size = @letters;
	for (my $i = 0; $i < $size; $i++) {
		$correctLetters[$i] = "_";
	}
}

sub resetVariables {
	$wrongGuess = 0;
	$solve = 0;
	@guessedLetters = ();
}

sub printWord {
	system ("cls");
	my $guessed = @guessedLetters;
	my $size = @correctLetters;
	say "You have made $wrongGuess incorrect guesses so far out of $maxWrongGuesses.";
	say "The following letters have been guessed:";
	for (my $i = 0; $i < $guessed; $i++) {
		print "$guessedLetters[$i] ";
	}
	print "\n";
	for (my $i = 0; $i < $size; $i++) {
		print "$correctLetters[$i] ";
	}
	print "\n"
}

sub setGuess {
	printWord();
	$guess = 0;
	while ($guess !~ /^[a-z]$/) {
		say "Give a letter to guess at the word.";
		chomp ($guess = <STDIN>);
		if ($guess !~ /^[a-z]$/) {
			say "\nINVALID INPUT";
			sleep 2;
			system ("cls");
			printWord();
		}
	}
	confirm();
}

sub confirm {
	my $size = @guessedLetters;
	for (my $i = 0; $i < $size; $i++) {
		if ($guessedLetters[$i] eq $guess) {
			say "Letter has already been guessed.";
			sleep 2;
			setGuess();
		}
	}
}

sub addGuess {
	my $size = @guessedLetters;
	$guessedLetters[$size] = $guess;
}

sub checkGuess {
	my $size = @correctLetters;
	my $wrong = 1;
	for (my $i = 0; $i < $size; $i++) {
		if ($letters[$i] eq $guess) {
			$correctLetters[$i] = $guess;
			$wrong = 0;
		}
	}
	if ($wrong == 1) {
		$wrongGuess++;
	}
}

sub checkSolve {
	my $size = @letters;
	my $correct = 0;
	for (my $i = 0; $i < $size; $i++) {
		if ($letters[$i] eq $correctLetters[$i]) {
			$correct++;
		}
	}
	if ($correct == $size) {
		$solve = 1;
	}
}

sub results {
	if ($solve == YES) {
		say "YOU HAVE WON!!!";
		sleep 5;
		system ("cls");
	} else {
		say "TRY AGAIN NEXT TIME";
		sleep 5;
		system ("cls")
	}
}