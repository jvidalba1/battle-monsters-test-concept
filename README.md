# README

# Coding Challenge

The app is a battle of monsters, where we have different monsters with different stats like attack and defense, for example, and we can let them fight each other.

We have implemented almost the entire CRUD for the Battle of Monsters app, and we have a battle endpoint to list all battles.

### Goals

- Implement missing functionalities: endpoints to list all monsters, start a battle, and delete a battle.

- Work on tests marked with `TODO`.

### Important considerations

- Do NOT modify already implemented tests. If your code is implemented correctly, these tests should pass without modifications.

- **You will face some issues in making the app run, this is part of the challenge, and we expect that you can fix them.**

### Battle algorithm

For calculating the battle algorithm, take into account the flow below:

- The monster with the highest speed makes the first attack, if both speeds are equal, the monster with the higher attack goes first.

- For calculating the damage, subtract the defense from the attack `(attack - defense)`; the difference is the damage; if the attack is equal to or lower than the defense, the damage is 1.

- Subtract the damage from the HP `(HP = HP - damage)`.

- Monsters will battle in turns until one wins; all turns should be calculated in the same request; for that reason, the battle endpoint should return winner data in just one call.

- Who wins the battle is the monster who subtracted the enemy’s HP to zero

### Acceptance Criteria

1. All monster endpoints were implemented and working correctly.
2. All battle endpoints were implemented and working correctly.
3. Failing old tests should pass.
4. All `TODO` tests were implemented successfully.
5. Test code coverage should be at least 80%, and you must run it and show it to us during the recording.
6. The code style check script must pass on completion of the challenge without any modifications to the config.
