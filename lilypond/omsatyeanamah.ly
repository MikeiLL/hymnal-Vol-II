\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key bes \major
  \time 7/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			bes4 ces d e8 e f2. |
			f4 e d ces8 ces d2. |
			d4 ces d e8 e d2 ces8 ces |
			d4 ces8 ces d4 ces8 ces bes2. |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om sat -- yei na -- ma -- ḥ
	Om sat -- yei na -- ma -- ḥ
	Om sat -- yei na -- ma -- ḥ
	na -- ma -- ḥ na -- ma -- ḥ na -- ma -- ḥ
}

harmonies = \chordmode {
	g1:m/bes | 
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