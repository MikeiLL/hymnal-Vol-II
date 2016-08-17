\version "2.19.45"

melody = \relative c'' {
  \clef treble
  \key f \minor
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			c4 aes g f | aes8( g) aes g aes g f4 |
			c'4 aes g f | aes8 g aes g d g f4 |
			d f g f | d8 f f g aes g f4 |
			c'4 aes g f | aes8( g) aes g aes g f4 |
		}
		\repeat volta 2 {
			aes'8 f4 ees8 ces bes aes4 | r8 f aes bes ces ees f4 |
			aes8 f4 ees8 ces bes aes4 | d,8 f4 g8 aes( g) f4 |
		}
		\repeat volta 2 {
			ees8. ees16 f8 f aes4 f | aes8. aes16 bes8 bes ces4 bes |
			ces8. ces16 ees8 ees f4 ees | ces8. ces16 bes8 bes aes4 f |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om Ma Sri Ma | A__ -- nan -- da -- ma -- yi Ma |
	Om Ma Sri Ma | Cit -- ti shak -- ti gu -- ru Ma |
	Om Ma Sri Ma | Ku -- la  Kun -- da -- li -- ni Ma |
	Om Ma Sri Ma | A__ -- nan -- da -- ma -- yi Ma |
	Shi -- va -- ya na -- ma Om | Shi -- va -- ya na -- ma Om |
	Shi -- va -- ya na -- ma Om | Na -- ma Shi -- va -- ya |
	Om na -- va Shi -- va -- ya | Om na -- va Shi -- va -- ya |
	Om na -- va Shi -- va -- ya | Om na -- va Shi -- va -- ya |
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