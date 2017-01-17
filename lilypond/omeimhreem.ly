\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key bes \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			r4 bes bes a | c2 c |
			d16( f d8)~ d2. |
			c4 c d8 d c c |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om eim hrīm śrīm klīm saw__ sat chit ek -- am Brah -- ma
}

harmonies = \chordmode {
	bes1/f | bes:sus4/e | bes:sus4/e
	d:m/f |
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
      \harmonies
    }
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}