\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 4 c8 d
			\repeat volta 2 {
				e4 e r2 | g4 a g f8 e |
				d4 c r c | r c r a |
				c1~ | c4 r2 a4 |
				c1 | r2. c8 d | 
			}
		}
}

text =  \lyricmode {
	ma -- ni -- pu -- ra
	ram ram ram ma -- ni -- pu -- ra
	ram ram I am. Sat Nam. Ma -- ni 
}

\score {
  <<
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { }
}