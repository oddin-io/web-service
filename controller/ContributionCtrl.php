<?php
namespace BossEdu\Controller;

use BossEdu\Model\McMaterialQuery;
use BossEdu\Model\Contribution;
use BossEdu\Model\ContributionQuery;
use BossEdu\Model\Map\ContributionTableMap;
use BossEdu\Model\McMaterial;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;

class ContributionCtrl
{
    public function authorize()
    {
        return AuthCtrl::check();
    }

    private function insertFile($file, $comment)
    {
        if (isset($file) && !empty($file)) {
            if ($file["error"]) {
                throw new RestException(410, "File error: ".$file["error"]);
            }

            $material_id = new McMaterial();
            $material_id->setFile(fopen($file["tmp_name"], "rb"));
            $material_id->setName(basename($file["name"]));
            $material_id->setMime($file["type"]);
            $material_id->setContributionId($comment);
            $material_id->save();
        }
    }

    /**
     * @noAuth
     * @url OPTIONS /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution
     */
    public function optionsContribution($instruction_id, $presentation_id, $doubt_id)
    {
        AuthCtrl::preFlightResponse();
    }

    /**
     * @url POST /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution
     */
    public function newContribution($instruction_id, $presentation_id, $doubt_id)
    {
        header("Content-Type: application/json");

        $presentation_id = urldecode($presentation_id);
        $doubt_id = urldecode($doubt_id);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 1)) {
            $data = Util::adjustArrayCase($_POST, "lower");
            $contribution = new Contribution();
            $contribution->fromArray($data, ContributionTableMap::TYPE_FIELDNAME);
            $contribution->setDoubtId($doubt_id);
            $contribution->setPersonId($person);
            $contribution->save();

            $commentId = $contribution->getId();

            if (isset($_FILES) && !empty($_FILES)) {
                $video = $_FILES["video"];
                $audio = $_FILES["audio"];

                $this->insertFile($video, $commentId);
                $this->insertFile($audio, $commentId);

                foreach ($_FILES["misc"] as $key => $value) {
                    $this->insertFile($value, $commentId);
                }
            }

            echo json_encode($contribution->toArray());
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution
     */
    public function getContributions($instruction_id, $presentation_id, $doubt_id)
    {
        header("Content-Type: application/json");

        $presentation_id = urldecode($presentation_id);
        $doubt_id = urldecode($doubt_id);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $contributions = ContributionQuery::create()
                ->join("Contribution.Pessoa")
                ->filterByDoubtId($doubt_id)
                ->select([
                    "Contribution.Id"
                    , "Contribution.Text"
                    , "Person.Name"
                    , "Contribution.CreatedAt"
                ])
                ->find()
                ->toArray();

            $contributions = ["contributions" =>
                Util::adjustArrayCase(Util::namespacedArrayToNormal($contributions, ["Contribution", "Person"]), "lower")
            ];

            echo json_encode($contributions);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @noAuth
     * @url OPTIONS /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution/$contribution_id
     */
    public function optionsGetContribution($instruction_id, $presentation_id, $doubt_id, $contribution_id)
    {
        AuthCtrl::preFlightResponse();
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution/$contribution_id
     */
    public function getContribution($instruction_id, $presentation_id, $doubt_id, $contribution_id)
    {
        header("Content-Type: application/json");

        $presentation_id = urldecode($presentation_id);
        $doubt_id = urldecode($doubt_id);
        $contribution_id = urldecode($contribution_id);
        $person = AuthCtrl::getSession()["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $contributions = ContributionQuery::create()
                ->join("Contribution.Person")
                ->filterByDoubtId($doubt_id)
                ->filterById($contribution_id)
                ->select([
                    "Contribution.Id"
                    , "Contribution.Text"
                    , "Person.Name"
                    , "Contribution.CreatedAt"
                ])
                ->findOne();

            $contributions = Util::adjustArrayCase(Util::namespacedArrayToNormal($contributions, ["Contribution", "Person"]), "lower");

            echo json_encode($contributions);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @noAuth
     * @url OPTIONS /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution/$contribution_id/materials
     */
    public function optionsGetContributionsMaterial($instruction_id, $presentation_id, $doubt_id, $contribution_id)
    {
        AuthCtrl::preFlightResponse();
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution/$contribution_id/materials
     */
    public function getContributionMaterials($instruction_id, $presentation_id, $doubt_id, $contribution_id)
    {
        $presentation_id = urldecode($presentation_id);
        $contribution_id = urldecode($contribution_id);
        $person = AuthCtrl::getSession()["id"];

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $materials = McMaterialQuery::create()
                ->filterByContributionId($contribution_id)
                ->select(["Id", "Nome", "Mime"])
                ->find();

            $materials = ["materials" =>
                Util::adjustArrayCase($materials, "lower")
            ];
            echo json_encode($materials);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @noAuth
     * @url OPTIONS /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution/$contribution_id/materials/$material_id
     */
    public function optionsGetContributionMaterial($instruction_id, $presentation_id, $doubt_id, $contribution_id, $material_id)
    {
        AuthCtrl::preFlightResponse();
    }

    /**
     * @url GET /instruction/$instruction_id/presentation/$presentation_id/doubt/$doubt_id/contribution/$contribution_id/materials/$material_id
     */
    public function getContributionMaterial($instruction_id, $presentation_id, $doubt_id, $contribution_id, $material_id)
    {
        $presentation_id = urldecode($presentation_id);
        $person = AuthCtrl::getSession()["id"];
        $material_id = urldecode($material_id);

        if (PresentationCtrl::auth($presentation_id, $person, 0)) {
            $material_id = McMaterialQuery::create()
                ->findOneById($material_id);

            if ($material_id) {
                header("Content-Type: ".$material_id->getMime());
                header("Content-Disposition: attachment; filename=\"".$material_id->getName()."\"");
                header("Cache-Control: no-cache, no-store, must-revalidate");
                header("Pragma: no-cache");
                header("Expires: 0");
                fpassthru($material_id->getFile());
                exit(0);
            } else {
                throw new RestException(404, "File");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }
}
