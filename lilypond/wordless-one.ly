\version "2.19.45"

\header {
  title = "Wordless One"
  composer = "Music by Rivka and Mike iLL"
  % tagline = "Copyright Rivka and Mike iLL Kilmer Creative Commons Attribution-NonCommercial BMI - Engraving by Lilypond"
}


melody = \relative c'' {
	\tempo 4 = 110
  \clef treble
  \key a \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			 \teeny a8 \tiny r a b cis r e fis | a4 fis8 a fis r e fis | e r cis e cis r b cis | b4 a8 r a r a r 
		}
	}
}

text =  \lyricmode {
	ba ba -- ta ba ba -- ta | ba ba -- ta ba ba -- ta |
	ba ba -- ta ba ba -- ta | ba ba ba ba  |
}


twochords = \chordmode { a2 e:7 }
reverse = \chordmode { e:7 a2 }

harmonies = {
	\twochords \twochords \twochords \reverse

}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { }
}