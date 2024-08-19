\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key c \minor
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			c r2 r8 bes~ | bes4 bes bes8 bes4 c8~ |
			c4 r2 r8 bes~ |bes4 bes bes bes8 c~ |
			c4 r2. | bes4 bes bes8 bes4. |
			c4 r2 bes4 | c4 r2 bes4 |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	One world is on our hands.
	Love is our com -- mand.
	Sis -- ter -- hood of man.
	All one. All 
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