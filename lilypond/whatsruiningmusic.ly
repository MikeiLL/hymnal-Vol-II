\version "2.19.45"
\paper {
	line-width = 4.6\in
}

upper = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4
  \repeat volta 2 {
		c2 b | a4 a8 b a g e4 | f2 e | d4 d8 c e d a4 |
		c2 d | e4. g8 a g e4 | f2 e | d8 e d b b a g4 |
  }
}

chordNotes =  \relative c {
  \clef bass
  	e2 d | c b | a g | f g | 
  	a f | g2. r4 | a2 g | f g4 r |
  }

\score {
  \new PianoStaff <<
    \new Staff = "upper" \upper
    \new Staff = "lower" \chordNotes
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
    \midi { 
  	\tempo 4 = 125
  }
}