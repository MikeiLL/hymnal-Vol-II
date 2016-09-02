\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key d \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
		  e2 e | e4 b8 a g4 a |
		  e2 e | e4 b'8 a g4 a |
		}
	}
}

text =  \lyricmode {
	Lam Lam Lam Mu -- la -- dha -- ra
	Lam Lam Lam Mu -- la -- dha -- ra
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
    }
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    	\new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 125
  }
}