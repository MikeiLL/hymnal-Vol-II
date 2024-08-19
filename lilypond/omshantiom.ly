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
		\repeat volta 2 {
		 c2 c4 des | c2 c4 c | des2 des4 des | c1 |
		}
	}
}

text =  \lyricmode {
	Om Śān -- tiḥ Om Śān -- tiḥ Om Śān -- tiḥ Om
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
  	\tempo 4 = 116
  }
}