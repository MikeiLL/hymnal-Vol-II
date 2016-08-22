\version "2.11.60"
% this is the latest development version. The file should work on earlier
% versions too, although the compiler may complain. Change to your own
% version number, or upgrade your installation.
%
% Everything after a "%" is a comment, which is ignored in the output.
% 
% To generate png files suitable for inclusion, open the console (on
% windows: Win-r), move to the directory with your files,  and type 
%
% lilypond -dbackend=eps -dno-gs-load-fonts -dinclude-eps-fonts --png -dresolution=600 <filename>.ly 
%======================================================================


\header {
  title = ""
	subtitle = ""
	subsubtitle = ""
	composer = ""
	poet = ""
	tagline = ##f
}

% This setting corresponds to the mystaffsize variable defined in layout
% section below.
#(set-global-staff-size 14) 

genStuff = {
	\key c\major
	\time 4/4
}

%======================================================================
% The following sections are "variables" with the different melodies,
% defined here and entered into the score later on. This is a convenience
% to make the file easier to read. It is not strictly necessary -- it could
% all have been written directly into the \score section, but it is more
% organized this way.
% 
% I've found it most convenient in situations like this, with several
% different melodic versions of possibly different length vertically
% aligned, to use tuplets (defined with "\times x/y {}").
%
% \startGroup and \stopGroup are for the brackets. The \markup command is a
% hack to get the label in place; here, it's tied to a note within the
% bracket. I haven't figured out how to tie them to the brackets
% themselves. "^" means: place above staff. "_" would place it below.
%======================================================================

Lo = \relative c'' {
	\genStuff
	\clef treble
	\set Staff.instrumentName = "Lo4951"
	
	\times 4/9 { c\startGroup c c d c^\markup{a} b a a g\stopGroup }
	\times 4/7 { s s s g a g s }
	\times 4/9 { a\startGroup b c b a^\markup{c} c a a g\stopGroup }
}

PaA = \relative c'' {
	\set Staff.instrumentName = "Pa776"
	\genStuff
	\clef treble

	\times 4/9 { c\startGroup c c d c^\markup{a} b a a g\stopGroup }
	\times 4/8 { a\startGroup c b a^\markup{b} g g a g\stopGroup }
	s1
}

PaB = \relative c'' {
  \genStuff
	\clef treble
	\set Staff.instrumentName = "Pa780"

	\times 4/9 { c4\startGroup c c d c^\markup{a} b a a g\stopGroup }
	\times 4/8 { a\startGroup c b a^\markup{b} g g a g\stopGroup }
	\times 4/9 { a\startGroup b c b a^\markup{c} c a a g\stopGroup }

}

textA = \lyricmode { 
%======================================================================
% if you want text in the examples, fill them in here, syllables separated
% with <space>--<space>, and add "\new Lyrics \textA" (etc.) at the place
% in the score declaration below where you want the text to appear
%======================================================================
}

%======================================================================
% Here, the variables defined above are entered into the score. The <<...>>
% indicates "polyphonic music", i.e. separate staves.
%======================================================================

\score {
	\new StaffGroup {
	<<
	  \new Staff \Lo
	  %\new Lyrics \textA
	  \new Staff \PaA
	  \new Staff \PaB
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
			\remove "Stem_engraver" 
			\remove "Tuplet_engraver"
			\override NoteHead #'style = #'baroque
			\remove "Note_spacing_engraver"
	}
	\context {
		\Staff
			\remove "Time_signature_engraver"
			%\override BarLine #'X-extent = #'(-1 . 1)
			\consists "Horizontal_bracket_engraver" 

	}
	\context {
		\Score
			\override HorizontalBracket #'direction = #1
			\override HorizontalBracket #'bracket-flare = #'(0.2 . 0.2)
			\override BarLine #'hair-thickness = #0.5
			\override BarNumber  #'padding = #2
	}
	\context {
		\StaffGroup 
			\remove "System_start_delimiter_engraver"
	}
  } % this brace ends the \layout section
} % this brace ends the \score section
