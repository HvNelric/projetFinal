<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass="App\Repository\UserRepository")
 * @UniqueEntity(fields="email", message="Il existe déjà un utilisateur avec cet email")
 */
class User implements UserInterface, \Serializable
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var ArrayCollection
     * @ORM\ManyToMany(targetEntity="App\Entity\Activites", inversedBy="user_activites")
     * @ORM\JoinTable(name="user_activites")
     */
    private $activites;

    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="App\Entity\Reservation", mappedBy="user_reservation")
     */
    private $reservation;

    /**
     * @var ArrayCollection
     * @ORM\ManyToMany(targetEntity="App\Entity\Region", inversedBy="user_region")
     * @ORM\JoinTable(name="user_region")
     */
    private $region;

    /**
     * @ORM\Column(type="string", length=255, unique=true)
     * @Assert\NotBlank(message="L'email est obligatoire")
     * @Assert\Email(message="Cet email n'est pas valide")
     */
    private $email;

    /**
     * @ORM\Column(type="string", length=20)
     */
    private $role = 'ROLE_USER';

    /**
     * @var string
     * @Assert\NotBlank(message="Le mot de passe est obligation")
     */
    private $plainPassword;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $password;

    /**
     * @var string
     * @ORM\Column(type="string", length=20)
     */
    private $sexe;

    /**
     * @ORM\Column(type="string", length=20)
     * Validation :
     *  -non vide
     * @Assert\NotBlank(message="Le nom est obligatoire")
     *  -nombre de caractères
     * @Assert\Length(max="20", maxMessage="Le nom ne doit pas dépasser {{ limit }} caractères")
     */
    private $prenom;

    /**
     * @ORM\Column(type="string", length=20)
     */
    private $nom;

    /**
     * @ORM\Column(type="integer")
     */
    private $age;

    /**
     * @var \DateTime
     * @ORM\Column(type="date")
     */
    private $date_dispo;

    /**
     * @var \DateTime
     * @ORM\Column(type="date")
     */
    private $date_fin;

    public function __construct()
    {
        $this->reservation = new ArrayCollection();
        $this->activites = new ArrayCollection();
        $this->region = new ArrayCollection();
    }

    public function getId()
    {
        return $this->id;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    public function getSexe()
    {
        return $this->sexe;
    }

    public function setSexe(string $sexe): self
    {
        $this->sexe = $sexe;

        return $this;
    }

    public function getPrenom()
    {
        return $this->prenom;
    }

    public function setPrenom(string $prenom): self
    {
        $this->prenom = $prenom;

        return $this;
    }

    public function getNom()
    {
        return $this->nom;
    }

    public function setNom(string $nom): self
    {
        $this->nom = $nom;

        return $this;
    }

    /**
     * @return ArrayCollection
     */
    public function getActivites()
    {
        return $this->activites;
    }

    /**
     * @return ArrayCollection
     */
    public function getReservation()
    {
        return $this->reservation;
    }

    /**
     * @return ArrayCollection
     */
    public function getRegion()
    {
        return $this->region;
    }

    /**
     * @param ArrayCollection $region
     * @return User
     */
    public function setRegion(ArrayCollection $region) :User
    {
        $this->region = $region;
        return $this;
    }

    /**
     * @param ArrayCollection $reservation
     * @return User
     */
    public function setReservation(ArrayCollection $reservation): User
    {
        $this->reservation = $reservation;
        return $this;
    }

    /**
     * @return string
     */
    public function getRole()
    {
        return $this->role;
    }

    /**
     * @param string $role
     */
    public function setRole(string $role): self
    {
        $this->role = $role;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getAge()
    {
        return $this->age;
    }

    /**
     * @param mixed $age
     * @return User
     */
    public function setAge($age)
    {
        $this->age = $age;
        return $this;
    }

    /**
     * @return \DateTime
     */
    public function getDateDispo()
    {
        return $this->date_dispo;
    }

    /**
     * @param \DateTime $date_dispo
     * @return User
     */
    public function setDateDispo(\DateTime $date_dispo): User
    {
        $this->date_dispo = $date_dispo;
        return $this;
    }

    /**
     * @return \DateTime
     */
    public function getDateFin()
    {
        return $this->date_fin;
    }

    /**
     * @param \DateTime $date_fin
     * @return User
     */
    public function setDateFin(\DateTime $date_fin): User
    {
        $this->date_fin = $date_fin;
        return $this;
    }


    /**
     * @return string
     */
    public function getPlainPassword()
    {
        return $this->plainPassword;
    }

    /**
     * @param string $plainPassword
     * @return User
     */
    public function setPlainPassword(string $plainPassword): User
    {
        $this->plainPassword = $plainPassword;
        return $this;
    }

    /**
     * Transforme l'objet en chaîne de caractère normée
     */
    public function serialize()
    {
        return serialize([
            $this->id,
            $this->prenom,
            $this->nom,
            $this->email,
            $this->password
        ]);
    }

    /**
     * Transforme une chaîne générée par serialize()
     * en objet
     *
     * @param string $serialized
     */
    public function unserialize($serialized)
    {
        list(
            $this->id,
            $this->prenom,
            $this->nom,
            $this->email,
            $this->password
            ) = unserialize($serialized);

    }

    public function getRoles() {
        return [$this->role];
    }

    public function getUsername() {

    }

    public function eraseCredentials() {

    }

    public function getSalt() {
        return null;
    }

    public function __toString()
    {
        return $this->sexe;
    }
}
