\version "2.19.45"
\paper {
	line-width = 4.6\in
}

upper = \relative c'' {
  \clef treble
  \key a \minor
  \time 7/8
  \repeat volta 2 {
		a8 r2. | gis8 r2. |
		fis8 r2. | e8 r2. |
		d8 r2. | c'8 r2. |
		b8 r2. | a8 r2. |
		g8 r2. | fis8 r2. |
		e8 r2. | d8 r2. |
		c8 r2. | b8 r2. |
  }
  \repeat volta 2 {
		e'8 r4 a8 r4. | e8 r4 a8 r a r |
  }
}

chordNames = \new ChordNames \chordmode {
    a:m
  }

chordNotes =  \relative c {
  \repeat percent 14 {
  	\clef bass
  	a8 r8 
  	<c e fis>
  	e,8 r8 <c' e fis> r8
  }
  \repeat percent 2 {
  	\clef bass
  	a8 r8 
  	<c e fis>
  	e,8 r8 <c' e fis> r8
  }
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