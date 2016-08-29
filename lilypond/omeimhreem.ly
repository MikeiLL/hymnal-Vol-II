\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key bes \major
  \time 3/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			bes4 bes a | \time 6/4 c2 c d16( f d8)~ d4 |
			\time 4/4 c4 c d8 d c c |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om eim hreem shreem kleem saw__ sat chit ekam Bramah
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}