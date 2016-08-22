\version "2.19.45"
\paper {
	line-width = 4.6\in
}

upper = \relative c' {
  \clef treble
  \key f \major
		f2. g8 a bes4 a g f a f g f d2 
		f g8 a bes4 a g f a f g2 
		f g8 a bes4 a g2 f d e 
		f4 g8 a bes4 a g2 f1 d2 e c1
}


\score {
	\new StaffGroup {
	<<
	  \new Staff \upper
	  >>
	}

%======================================================================
% Everything below this point is settings to override standard notation to
% get stemless notes etc., and to get a layout which you can copy to
% all the different files. Even better: save it in a separate file in the
% same directory as the music files, e.g. layout.ly and add the line 

% \include "layout.ly"

% at this point. Then, if you want to make changes, you can do them in one
% place instead of in every single file.
%
% You will need to change the font tree, since you won't have these fonts
% installed. They are the serif, the sans-serif, and the monospaced fonts,
% in that order.
%======================================================================

\layout {
	indent = 0\cm
	ragged-last = ##t
	myStaffSize = #14 
	#(define fonts 
			(make-pango-font-tree
			"JensonOSN"
			"Futura Bk BT"
			"Lucida Console"
			(/ myStaffSize 20)))
	line-width = 11.75\cm
	left-margin = 2\mm
	ragged-bottom = ##t
	ragged-bottom-last = ##t
	between-system-space = 9\mm
	paper-width = 12\cm
	paper-height = 20\cm
	page-top-space = 0\cm
	head-separation = 0\cm
	evenFooterMarkup = ##f
	oddFooterMarkup = ##f
	oddHeaderMarkup = ##f
	evenHeaderMarkup = ##f
	bookTitleMarkup = ##f
	scoreTitleMarkup = ##f
	\context { 
		\Voice 
			\remove "Tuplet_engraver"
			\override NoteHead #'style = #'baroque
			\remove "Note_spacing_engraver"
	}
	\context {
		\Staff
			%whichBar = #"" 
			\remove "Time_signature_engraver"
			\remove "Bar_engraver"
			%\override BarLine #'X-extent = #'(-1 . 1)
			\consists "Horizontal_bracket_engraver" 

	}
	\context {
		\Score
			\override HorizontalBracket #'direction = #1
			\override HorizontalBracket #'bracket-flare = #'(0.2 . 0.2)
			\override BarLine #'hair-thickness = #0.001
			\override BarNumber  #'padding = #2
	}
	\context {
		\StaffGroup 
			\remove "System_start_delimiter_engraver"
	}
  } % this brace ends the \layout section
} % this brace ends the \score section
    