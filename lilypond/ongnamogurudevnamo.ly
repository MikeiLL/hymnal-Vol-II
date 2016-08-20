\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key g \minor
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\repeat volta 2 {
				g4 bes8 c4 r8 c8  d | c r bes c4 r8 c d |
				f r f d c4 bes8 bes( | g2.) r4 |
			}
		}
}

text =  \lyricmode {
	Ong na -- mo gu -- ru dev na -- mo gu -- ru
	dev gu -- ru dev na -- mo__ |
}

harmonies = \chordmode { 
	g1:m
}

chordNotes =  \relative c {
  \repeat percent 4 {
  	\clef bass
  	g8 r4 <bes d>8 r <bes d> d, d |
  }
}
  

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new PianoStaff <<
    \new Staff = "upper" \melody
    \new Staff = "lower" \chordNotes
  	>>
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}