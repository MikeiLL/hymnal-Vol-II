\version "2.19.45"

\paper {
	line-width = 4.6\in
}

#(define (parenthesis-ignatzek-chord-names in-pitches bass inversion context) 
(markup #:line ("(" (ignatzek-chord-names in-pitches bass inversion context) ")")))

melody = \relative c' {
  \clef treble
  \key f \minor
  \time 3/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			f2.~ | f2 ees4 |
			f4 ees f | ees2 ees4 |
			f f g | aes2 ees4 | % being oh lead from
			f ees f | ees f8 ees f4 |
			ees f g | aes2 ees4 |
			f2 f4 | ees f ees | % death me to eternal
			f f g4 | aes2 bes4 |
			c2. | c | c~ | c
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om. From non- -- be -- ing me to
	be -- ing oh lead.
	From dark -- ness me to e -- ver -- las -- ting 
	light, oh lead.
	From death me to e -- ter -- nal
	life, oh lead. Om peace peace peace.
}

harmonies = \chordmode {
	f2.:m | f2.:m | f2.:m | f2.:m | f2.:m | 
	\set chordNameFunction = #parenthesis-ignatzek-chord-names 
		f:7
	\unset chordNameFunction  
	bes:m | bes:m | bes:m | bes:m7 |
	g:m7.5- | g:m7.5- | c:7 | c:7 | 
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
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
  \midi { }
}

