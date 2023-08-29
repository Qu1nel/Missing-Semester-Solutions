1. Entropy

   1. Suppose a password is chosen as a concatenation of four lower-case
      dictionary words, where each word is selected uniformly at random from a
      dictionary of size 100,000. An example of such a password is
      `correcthorsebatterystaple`. How many bits of entropy does this have?

      **Solution:**

      ```
      n = 100_000
      k = 4
      ```

      > answer: $H(X): = \lceil log_2(n^k) \rceil = \lceil log_2(100,000^4) \rceil = 66bit$

   2. Consider an alternative scheme where a password is chosen as a sequence of
      8 random alphanumeric characters (including both lower-case and upper-case
      letters). An example is `rg8Ql34g`. How many bits of entropy does this have?

      **Solution:**

      ```
      n = 10 + 26 * 2  # 62
      k = 8
      ```

      > answer: $H(X): = \lceil log_2(n^k) \rceil = \lceil log_2(62^8) \rceil = 47bit$

   3. Which is the stronger password?

      **Solution:**

      > The first: `correcthorsebatterystaple`

   4. Suppose an attacker can try guessing 10,000 passwords per second.
      On average, how long will it take to break each of the passwords?

      **Solution:**

      > The first password with an entropy of `66` bits would take `2339769` thousand years.

      > The second password with an entropy of `47` bits would take `446` years.
