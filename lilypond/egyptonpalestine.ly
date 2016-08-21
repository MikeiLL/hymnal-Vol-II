\version "2.19.45"
\paper {
	line-width = 4.6\in
}

upper = \relative c' {
  \clef treble
  \key a \major
  \time 4/4
  \partial 4 fis4
  \repeat volta 2 {
  	a b cis e | d cis8 b a4 b | cis a b2 | gis4 a2 fis4 |
	}
}

\score {
    \new Staff = "upper" \upper
  \layout { 
   % #(layout-set-staff-size 14)
   }
    \midi { 
  	\tempo 4 = 125
  }
}