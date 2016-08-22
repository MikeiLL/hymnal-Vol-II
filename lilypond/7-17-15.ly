\version "2.19.45"
\paper {
	line-width = 4.6\in
}

upper = \relative c'' {
  \clef treble
  \key d \major
  \repeat volta 2 {
		ais8 fis fis' e d cis b4
	}
}

\score {
	\new StaffGroup {
	<<
	  \new Staff \upper
	  >>
	}

  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}