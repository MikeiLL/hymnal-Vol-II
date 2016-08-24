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
			c4-.
				des1. | c 1. | r1 c4 |
				bes1.~ | bes | 
				% caesura
				c4-.\breathe des4-. |
				g4~ g8. g16 | g2. | r1
			}
		}
}

text =  \lyricmode {
	ek ong kar sat nam siri wa -- he gu -- ru
}

bassline = \relative c {
\clef bass
	\time 1/4 c4-.
			\time 6/4 bes des f bes, des f |
			c e g c, e g \time 5/4 c, e g c-. c, |
			\time 6/4 bes des f des f g |
			aes8 g16 aes g4 f g8 f g f des4 |
			\time 4/4 c-. \breathe des-. des f
			\time 3/4 c e g 
			\time 4/4 c, e g c |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
    }
    \new PianoStaff <<
    \new Staff = "voice" \melody
    \new Lyrics \lyricsto "words" \text
    \new Staff = "violin" \bassline
  	>>
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { }
}