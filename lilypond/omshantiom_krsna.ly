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
		\repeat volta 3 {
		 r4 e8 e e4 e | r4 e8 e e4 e | r4 f8 f f4 f |
		}
		\alternative {
			{ e1 | }
			{ e2 e | }
			{ r4 e4 e2 | }
		}
	}
}

text =  \lyricmode {
	Kṛ -- ṣṇa Kṛ -- ṣṇa pri -- ya Kṛ -- ṣṇa Rā -- ma Rā -- ma Om śān -- tiḥ swa -- ha
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