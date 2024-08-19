\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key aes \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
	\partial 8 aes8
		\repeat volta 2 {
			c c~ c2~ c8 c | bes bes4 bes8 aes aes4 aes8 |
			f f r2 aes8 bes | c2 r2 | 
			f,1~ | f~ | f~ | f~ |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Sam -- |
	ska -- ra sam -- | ska -- ra sam -- ska -- ra sam -- |
	ska -- ra set -- tle | down |
	Om__
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
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