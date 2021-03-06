<?php
/**
 * Created by PhpStorm.
 * User: tomas
 * Date: 25/11/2018
 * Time: 21:40
 */

namespace App\Model;


class TeacherModel extends BaseModel implements IDatabaseWrapper {

    public function getAll(): array {
        return $this->database->fetchAll('SELECT * FROM SEM_P_UCITEL');
    }

    public function getById(string $id) {
        return $this->database->fetch('SELECT * FROM SEM_P_UCITEL WHERE ID = ?', $id);
    }

    public function updateById(string $id, array $changes): void {
        $this->database->query(
            'UPDATE SEM_UCITEL SET jmeno=?, prijmeni=?, titul_pred=?, titul_za=?, telefon=?, mobil=?, kontaktni_email=?, katedra_id=?  WHERE ID=?',
            $changes['firstName'],
            $changes['lastName'],
            $changes['prefixTitle'],
            $changes['postfixTitle'],
            $changes['telephone'],
            $changes['mobile'],
            $changes['email'],
            $changes['department'],
            $id
        );
    }

    public function deleteById(string $id): void {
        $this->database->query('DELETE FROM SEM_UCITEL WHERE ID=?', $id);
    }

    public function insert(array $item): string {
        $id = null;
        $statement = $this->database->getPdo()->prepare('INSERT INTO SEM_UCITEL (id, jmeno, prijmeni, titul_pred, titul_za, telefon, mobil, kontaktni_email, katedra_id) VALUES (SEM_UCITEL_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id INTO ?');
        $statement->bindParam(1, $item['firstName']);
        $statement->bindParam(2, $item['lastName']);
        $statement->bindParam(3, $item['prefixTitle']);
        $statement->bindParam(4, $item['postfixTitle']);
        $statement->bindParam(5, $item['telephone']);
        $statement->bindParam(6, $item['mobile']);
        $statement->bindParam(7, $item['email']);
        $statement->bindParam(8, $item['department']);
        $statement->bindParam(9, $id, \PDO::PARAM_INT, 8);

        $statement->execute();

        return $id;
    }

    public function updateImage(string $id, string $imageId) {
        $this->database->query(
            'UPDATE SEM_UCITEL SET obrazek_id=?  WHERE ID=?',
            $imageId,
            $id
        );
    }
}