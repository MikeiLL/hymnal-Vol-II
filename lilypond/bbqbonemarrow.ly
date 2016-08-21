\version "2.19.45"
\paper {
	line-width = 4.6\in
}

upper = \relative c'' {
  \clef treble
  \key bes \major
  \time 4/4
  b4. c8 d-. ees4. | f ees8 d-. c4. |
  b4. c8 d-. ees4. | aes,2 g4-. d |
  f'4. ees8 d-. c4. | ees d8 c-. b4. |
  aes2 g4-. d~ | d aes' g-. r |
  f'4. ees8 f-. g4. | ees d8 ees-. f4. | 
  d c8 d-. ees4. | c b8 c-. d4. |
  b4. c8 d-. ees4. | f ees8 d-. c4. |
  ees d8 c b4. | aes2 g4 r |
  g'4. f8 g-. aes4. | g4. f8 g-. aes4. |
  g4. f8 g-. aes4. | b aes8 g2 |
  f4. ees8 d4 c | a2 b |
  c1~ | c1~ |
  c4. b8 c4 d | c4. b8 a4 g |
  g2( e4) a^"poco ritard. " | g2( e4) a~ | a2.\fermata
  
}

\score {
    \new Staff = "upper" \upper
  \layout { 
   % #(layout-set-staff-size 14)
   }
    \midi { 
  	\tempo 4 = 125
  }
}