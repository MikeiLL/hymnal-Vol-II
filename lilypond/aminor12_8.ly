\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key a \minor
  \time 12/8
  \new Voice = "words" {
		\repeat volta 2 {
		e4. e g~ g4 f8 |f4 e8 e4 d8 e4.~ e4 d8 |
		d4 c8 c4 b8 b4 a8 a4 b8 | c16 a~ a8~ a4~ a1 |
		e'4. e g~ g4 f8 |f4 e8 e4 e8 a4.~ a4 b8 | 
		c8 a4 a e'8 d4 c8 b4 c8 | b16 a~ a8~ a4~ a2 e |
		c4. c e~ e4 d8 | d4 c8 c4 b8 c4. c4 d8 |
		d4 c8 c4 b8 b4 a8 a4 b8 | c16 a~ a8~ a4. c8 e4.~ e4 c8( |
		d4.~) d4 f8 e4 d8 c4 b8 | c16 a~ a8~ a4~ a1 |
		}
		\repeat volta 2 { 
			d4.~ d4 f8 e4 d8 c4 b8 | c16 a~ a8~ a4~ a1 |
		}
	}
}

harmonies = \chordmode { 
	a1.:min | a:m | a:m | a:m |
	a:min | a:m | a:m | a:m |
	a:min | a:m | a:m | a:m |
	d2.:m e:7 | a1.:min |
	d2.:m e:7 | a1.:min |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}